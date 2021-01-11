# Yanglang Productions v3

## Building with Jekyll

```bash
make ci # clean build
make clean # rm artifacts
make image # docker build image
make build # jekyll build
make dev # build image + jekyll serve
```

The image needs (likely already configured by the included Dockerfile):

* `imagemagick6-dev` (`jekyll-responsive-image`)
* `libwebp-tools` (for webp support anyways)

## Notes

* Jekyll 4.2.0 may break jekyll-responsive-image 1.5.5, [so here is the fix](https://github.com/wildlyinaccurate/jekyll-responsive-image/pull/103). The container already has the patch.
* Iosevka 4.4.0
* Use `video-webm.sh` to convert `mp4` to `webm` for web
