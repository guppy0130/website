container_command = docker
build_command = docker buildx

ci: | clean build

clean:
	rm -rf _site vendor .jekyll-cache

image:
	$(build_command) build --tag jekyll:latest .

build:
	$(container_command) run --rm -v $(CURDIR):/srv/jekyll -e 'JEKYLL_ENV=production' -it guppy0130/jekyll:latest video-webm.sh && bundle exec jekyll build

dev: image
	$(container_command) run --rm -v $(CURDIR):/srv/jekyll -p 4000:4000 -p 35729:35729 --name jekyll -it jekyll:latest video-webm.sh && bundle exec jekyll build
