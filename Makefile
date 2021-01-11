container_command = docker
build_command = docker buildx

ci: | clean dirs video build

clean:
	rm -rf _site vendor .jekyll-cache

dirs:
	mkdir -p _site .jekyll-cache

video: dirs
	chmod +x video-webm.sh && ./video-webm.sh

build: dirs
	jekyll build --trace

image:
	$(build_command) build --tag jekyll:latest .

build-docker: image
	$(container_command) run --rm -v $(CURDIR):/srv/jekyll -e 'JEKYLL_ENV=production' -it jekyll:latest video-webm.sh && bundle exec jekyll build

dev-docker: image
	$(container_command) run --rm -v $(CURDIR):/srv/jekyll -p 4000:4000 -p 35729:35729 --name jekyll -it jekyll:latest video-webm.sh && bundle exec jekyll build
