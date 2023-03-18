---
layout: posts
title: Cache data in memory and update it regularly via a background service (.NET Core MinimalAPI example)
tags: .NET
excerpt_separator: <!--more-->
typora-root-url: ..
---

My backend needs to collect data. This takes a lot of time, so I don't want to collect the data with every API call, but instead cache it in memory. The cache should be updated regularly in a background thread. However, it should also be possible to explicitly initiate the update via an API call. How could this be implemented in .NET Core?

<!--more-->

## Example
Suppose we had the following scenario: we want to implement an API that provides GitHub statistics. There are *authors* and *projects* in GitHub. The API should read all authors and projects that exist in GitHub. This takes some time, and should not be done on every API call, but only every few hours. The data is cached in memory and our API does not collect the data every time, but works with the cached data.

The API should provide the following routes:

* `GET "/summary/authors"` should return the number of all authors, and information about the actuality of the cached data.
* `GET "/summary/projects"` should do the same for the number of projects.
* `POST "/triggerCacheUpdate/authors"` and `POST "/triggerCacheUpdate/projects"` should cause the data to be recollected.

Below I explain the example implementation from the outside in. First I explain the implementation of the services, then how the data is collected and finally how the cache is updated in the background. The complete example can also be found on [GitHub](https://github.com/FrankFK/in-memory-cache-example).

## Create .NET Core Minimal API 

In this example, I used .NET 6. First, using a tutorial on Microsoft Learn ([Tutorial: Create a minimal API with ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/tutorials/min-web-api?view=aspnetcore-7.0&tabs=visual-studio)), I created a REST service that displays "Hello World" and launched it once so that Visual Studio creates a certificate for it. Then I created the minimal APIs for the REST services I want. The tips from [Minimal APIs quick reference | Microsoft Learn](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis?view=aspnetcore-6.0) were very helpful here.

In the end `Program.cs` looks like this:

```csharp
using InMemCacheMinimalApi.Api;
using InMemCacheMinimalApi.BusinessLogic;
using InMemCacheMinimalApi.Cache;

var builder = WebApplication.CreateBuilder(args);

// General Services for caching
CachedDataConfiguration.AddServices(builder.Services);

// Services for generating the data
builder.Services.AddSingleton<ICachedDataEntryProducer, AuthorsDataProducer>();
builder.Services.AddSingleton<ICachedDataEntryProducer, ProjectsDataProducer>();

// Services for the APIs
builder.Services.AddScoped<ISummaryService, SummaryService>();
builder.Services.AddScoped<ICacheInfoService, CacheInfoService>();

var app = builder.Build();

app.MapGet("/summary/{objectType}", (string objectType, ISummaryService service) => service.Get(objectType));
app.MapPost("/triggerCacheUpdate/{objectType}", (string objectType, ICacheInfoService service) => service.TriggerUpdate(objectType));

app.Run();
```

For the REST API `GET "/summary/{objectType}"` there is an interface `ISummaryService` and a matching implementation `SummaryService`. The `SummaryService` class reads the cached author data and creates a summary from it:

```csharp
internal sealed class SummaryService : ISummaryService
{
    private readonly ICachedDataRepository _cachedDataRepository;

    public SummaryService(ICachedDataRepository cachedDataRepository)
    {
        _cachedDataRepository = cachedDataRepository;
    }
    public string Get(string objectType)
    {
        switch (objectType)
        {
            case "authors":
                if (_cachedDataRepository.GetEntry(typeof(ListOfAuthors)) is ListOfAuthors listOfAuthors)
                {
                    return $"{listOfAuthors.AuthorsCount} authors ({_cachedDataRepository.GetStateInfo(typeof(ListOfAuthors))})";
                }
                else
                    return $"No authors data found ({_cachedDataRepository.GetStateInfo(typeof(ListOfAuthors))})";
            case "projects":
                // Analogous to the authors case
        }
    }
}
```

The cache stores exactly one instance of a given object type (in this example `typeof(ListAuthors)`). 

* The call `_cachedDataRepository.GetEntry(typeof(ListOfAuthors))` can be used to read this instance from the cache. 
* The call to `_cachedDataRepository.GetStateInfo(typeof(ListOfAuthors))` returns a state like this: `(Cached data, 00:00:03.2600677 old, auto update in 00:01:56.7391128).` This allows the user to see how old the cache entry is and when it will be automatically updated.
* The cache was injected in the constructor via DI. I will explain this cache below.

For the REST API `POST "/triggerCacheUpdate/authors"` there is another interface and a service. This service is used to trigger the cache update:

```csharp
internal class CacheInfoService : ICacheInfoService
{
    private readonly ICachedDataUpdater _cachedDataUpdater;

    public CacheInfoService(ICachedDataUpdater cachedDataUpdater)
    {
        _cachedDataUpdater = cachedDataUpdater;
    }
    public string TriggerUpdate(string objectType)
    {
        switch (objectType)
        {
            case "authors":
                _cachedDataUpdater.TriggerUpdate(typeof(ListOfAuthors));
                return "Update is triggered.";
            case "projects":
                // Analogous to the authors case
        }
    }
}
```

The call `_cachedDataUpdater.TriggerUpdate(typeof(ListOfAuthors))` is used to trigger the update of the author data.  This is explained below.

# Generation of the data

The class `ListOfAuthors` contains the data of all authors:

```csharp
internal sealed class ListOfAuthors : ICachedDataEntry
{
    private readonly List<AuthorData>? _authors;

    public ListOfAuthors(List<AuthorData>? authors)
    {
        _authors = authors;
    }

    public TimeSpan MaxCacheTime { get { return new TimeSpan(0, 2, 0); } }

    public int AuthorsCount
    {
        get { return _authors != null ? _authors.Count : 0; }
    }
}
```

To interact with the cache, the class must implement the `ICachedDataEntry` interface. This contains a single property `MaxCacheTime`. Using this property, the class specifies how long the data should be cached (2 minutes in the example above).

A second class creates the data:

```csharp
internal class ListOfAuthorsProducer : ICachedDataEntryProducer
{
    public Type GeneratesDataType { get { return typeof(ListOfAuthors); } }

    public async Task<ICachedDataEntry> GenerateDataAsync()
    {
        ListOfAuthors result;
        // This is the code that has a long runtime
        await Task.Delay(15 * 1000); // Simulate  a time here
        result = new ListOfAuthors(new List<AuthorData> { new AuthorData("Stanislaw", "Lem"), ... });
        return result;
    }
}
```

For interaction with the cache, this class must implement the interface `ICachedDataEntryProducer`. This interface has two members:

* `GeneratesDataType` specifies which object type can be produced by this class (so here `typeof(ListOfAuthors)`).
* `GenerateDataAsync` is the method that collects all data and returns it. This method can take a long time.

Similary, there are the classes `ListOfProjects` and `ListOfProjectsProducer` for collecting the projects information.

The two producer classes must be provided in `Program.cs` for DI. Because they work in the background, they are registered as singletons:

```csharp
// Services for generating the data
builder.Services.AddSingleton<ICachedDataEntryProducer, ListOfAuthorsProducer>();
builder.Services.AddSingleton<ICachedDataEntryProducer, ListOfProjectsProducer>();
```



# Updating the data via a Background Service

Entry point for the automatic update is the class `CachedDataUpdateService`:

```csharp
internal class CachedDataUpdateService : BackgroundService
{
    private readonly ICachedDataUpdater _cachedDataUpdater;

    public CachedDataUpdateService(ICachedDataUpdater cachedDataUpdater)
    {
        _cachedDataUpdater = cachedDataUpdater;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            await _cachedDataUpdater.RunNeededUpdatesAsync();
            await Task.Delay(10000, stoppingToken);
        }
    }
}
```

This class is registered as a service at the beginning (by calling `CachedDataConfiguration.AddServices(builder.Services)` in `Program.cs`):

```csharp
public static class CachedDataConfiguration
{
    public static void AddServices(IServiceCollection services)
    {
        services.AddHostedService<CachedDataUpdateService>();
        services.AddSingleton<ICachedDataRepository, CachedDataRepository>();
        services.AddSingleton<ICachedDataUpdater, CachedDataUpdater>();
        services.AddSingleton<ICachedDataInternalRepository, CachedDataInMemCache>();

    }
}
```

The above `ExecuteAsync` method is called as BackgroundService and checks in an endless loop every 10 seconds if data has to be updated. For this it uses the DI injected `CacheDataUpdater`.

The implementation of `CacheDataUpdater` is a bit longer and is only shown here in parts. 

First the constructor:

```csharp
internal class CachedDataUpdater : ICachedDataUpdater
{
    private readonly ICachedDataInternalRepository _cachedDataRepository;
    private readonly Dictionary<string, ICachedDataEntryProducer> _producers = new();

    public CachedDataUpdater(IEnumerable<ICachedDataEntryProducer> producers, ICachedDataInternalRepository cachedDataRepository)
    {
        _cachedDataRepository = cachedDataRepository;
        foreach (var producer in producers)
        {
            _producers.Add(producer.GeneratesDataType.ToString(), producer);
        }
    }
    // ...
}
```

As first argument the constructor receives an parameter `IEnumerable<ICachedDataEntryProducer> producers`. In our example the two above defined producers `ListOfAuthorsProducer` and `ListOfProjectsProducer` are passed to the class. Each producer specifies via the property `GeneratesDataType` what kind of object it creates. The producers are stored in a dictionary according to this type. 

For storing the objects an `ICachedDataInternalRepository` is injected into the constructor. This is the in memory storage for the objects to be cached. Essentially, this is a `Dictionary` with the following structure:

* The type of the objects to be cached is used as the dictionary key.

* An object to be cached (i.e., for example, a `ListOfAuthors` object) is wrapped in a class called `CachedData`, which is stored as a dictionary value.

  ```csharp
  internal sealed class CachedData
  {
      public enum CacheState
      {
          OK,
          ShouldBeUpdated,
          InUpdate
      }
  
      private readonly DateTime _creationTime = DateTime.MinValue;
  
      public CachedData(ICachedDataEntry? entry)
      {
          Entry = entry;
          State = CacheState.ShouldBeUpdated;
          _creationTime = DateTime.MinValue;
      }
  
      public ICachedDataEntry? Entry { get; }
  
      public CacheState State { get; set; }
      public bool NeedsRefresh { get { return (DateTime.Now - _creationTime > Entry?.MaxCacheTime); } }
  }
  ```

  The `NeedsRefresh` property determines whether the cached record is already older than the maximum cache time requested by the `Entry`.

The `RunNeededUpdatesAsync` method calculates and caches the objects:

```csharp
internal class CachedDataUpdater : ICachedDataUpdater
{
    // ...
    public async Task RunNeededUpdatesAsync()
    {
        foreach (var dictEntry in _producers)
        {
            var producer = dictEntry.Value;
            string typeOfICachedDataEntry = producer.GeneratesDataType.ToString();
            // ...
            CachedData cachedData = _cachedDataRepository.Get(typeOfICachedDataEntry);
            if (cachedData == null || cachedData.State == CachedData.CacheState.ShouldBeUpdated || cachedData.AutoRefresh < TimeSpan.Zero)
            {
                // ...
                ICachedDataEntry newDataEntry = await producer.GenerateDataAsync();
                var newData = new CachedData(newDataEntry)
                {
                    State = CachedData.CacheState.OK
                };
                _cachedDataRepository.InsertOrUpdate(typeOfICachedDataEntry, newData);
            }
        }
    }
   // ...
}
```

The method `RunNeededUpdatesAsync` is called every 10 seconds by the background service described above. The code of this method is given here somewhat simplified, but the principle should be recognizable. At first it is determined which object type the producer can generate. Then the cache is checked to see if (a) the object is missing, (b) should be updated explicitly (`cachedData.State == CachedData.CacheState.ShouldBeUpdated`) or (c) if the object needs to be refreshed (`cachedData.NeedsRefresh`). If one of these conditions is true, the `GenerateDataAsync` method of the Producer is called and the recalculated result is stored in the cache.

The last method of `CacheDataUpdate` is the `TriggerUpdate` method:

```csharp
internal class CachedDataUpdater : ICachedDataUpdater
{
    public void TriggerUpdate(Type typeOfICachedDataEntry)
    {
        string key = typeOfICachedDataEntry.ToString();

        // ...
        CachedData cachedData = _cachedDataRepository.Get(key);
        cachedData.State = CachedData.CacheState.ShouldBeUpdated;
        _cachedDataRepository.InsertOrUpdate(key, cachedData);
        // ...
    }
}
```

A call to the REST API `POST "/triggerCacheUpdate/authors"` invokes the `TriggerUpdate` method of the `CacheDataUpdater` via intermediate steps. This method simply sets the status of the object in question in the cache to `ShouldBeUpdated`. The next time `RunNeededUpdatesAsync` is called, the object will then be updated.

# Summary

The core idea of this solution is that a background service (`CachedDataUpdateService`) handles the complete generation, update and caching of the data. The REST APIs use only cached data and therefore can deliver results without much delay. The classes for generating the data (`ListOfAuthorsProducer` and `ListOfProjectsProducer`) are passed to the background service via dependency injection (see the constructor of `CachedDataUpdater` ), thus this approach can be extended to include any number of data producers.

More details of this example can be found on [GitHub](https://github.com/FrankFK/in-memory-cache-example)

![SmallImage](https://woopec.net//assets/images/PostInMemCache.png)

