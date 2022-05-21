build: images videos | dirs
	jekyll build --trace

clean:
	rm -rf _site vendor .jekyll-cache *.log

dirs:
	mkdir -p _site/assets/resized/{300,500,800} .jekyll-cache

images: dirs
	./image-webp.sh

videos: dirs
	./video-webm.sh
	rm *.log
