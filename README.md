# Yanglang Productions v3

## Building with Jekyll

```bash
make ci # clean build
make clean # rm artifacts
make image # docker buildx image
make build # jekyll build
make dev # jekyll run public image
make bump-deps # update Gemfile.lock
```

The image needs (likely already configured by the included Dockerfile):

* `imagemagick6-dev` (`jekyll-responsive-image`)
* `libwebp-tools` (for webp support anyways)

## Notes

* Iosevka 4.4.0
* Use `video-webm.sh` to convert `mp4` to `webm` for web
