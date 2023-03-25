$JEKYLL_VERSION = "3.8"
docker run --rm -v "$((Get-Item .).FullName):/srv/jekyll:Z" -it jekyll/builder:$JEKYLL_VERSION jekyll build