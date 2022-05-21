#!/usr/bin/env bash

for width in 300 500 800; do
  find assets -name "*.jpg" -print0 | parallel -q0 --will-cite -verbose convert {} -resize ${width} _site/assets/resized/${width}/{/.}.webp
done
