container_command = docker
build_command = docker buildx

ci: | clean dirs video build

clean:
	rm -rf _site vendor .jekyll-cache *.log

dirs:
	mkdir -p _site .jekyll-cache

video: dirs
	chmod +x video-webm.sh && ./video-webm.sh

# github actions doesn't like it if you use bundler here
# it's likely due to the fact that all actions in the clone-dir are run as root
# and the jekyll:jekyll user is required for bundler (maybe from source image?)
build: dirs
	jekyll build --trace

image:
	$(build_command) build --tag jekyll:latest .

build-docker: image
	$(container_command) run --rm -v $(CURDIR):/srv/jekyll -e 'JEKYLL_ENV=production' -it jekyll:latest video-webm.sh && jekyll build

dev-docker: image
	$(container_command) run --rm -v $(CURDIR):/srv/jekyll -p 4000:4000 -p 35729:35729 --name jekyll -it jekyll:latest bundle exec jekyll serve --force_polling

dev:
	$(container_command) run --rm -v $(CURDIR):/srv/jekyll -p 4000:4000 -p 35729:35729 --name jekyll -it ghcr.io/guppy0130/jekyll:latest bundle exec jekyll serve --force_polling
