container_command = docker
build_command = docker buildx
# the build_run_base is the container + mounting required content
build_run_base = $(container_command) run --rm -v $(CURDIR):/srv/jekyll -it
# the run command takes care of interactive usage, really
run_command = $(build_run_base) -p 4000:4000 -p 35729:35729 --name jekyll
# the build command is more for prod builds
build_site_command = $(build_run_base) -e 'JEKYLL_ENV=production'

# the CI can take advantage of being in a linux environment to not have to run
# the video target inside the container
ci: | clean dirs video build

clean:
	rm -rf _site vendor .jekyll-cache *.log

dirs:
	mkdir -p _site .jekyll-cache

video: dirs
	chmod +x video-webm.sh && ./video-webm.sh && rm *.log

# github actions doesn't like it if you use bundler here
# it's likely due to the fact that all actions in the clone-dir are run as root
# and the jekyll:jekyll user is required for bundler (maybe from source image?)
build: dirs
	jekyll build --trace

# may take ~2min on windows? after that, repeated calls should be fine.
image:
	$(build_command) build --tag jekyll:latest .

# buildx takes care of caching and stuff so repeated calls to this should be fast
build-docker: image
	$(build_site_command) jekyll:latest video-webm.sh && rm *.log && jekyll build

# buildx takes care of caching and stuff so repeated calls to this should be fast
dev-docker: image
	$(run_command) jekyll:latest bundle exec jekyll serve --force_polling

# build against public image
dev:
	$(run_command) ghcr.io/guppy0130/jekyll:latest bundle exec jekyll serve --force_polling

# bump gem deps. Could potentially cause issues.
bump-deps: image
	$(run_command) jekyll:latest bundle update
