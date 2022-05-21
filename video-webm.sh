#!/usr/bin/env bash

AV_LOG_FORCE_COLOR=true # always color ffmpeg output

# params for webm conversion. This is CRF 30, and passlogfile/prefix based on
# GNU parallel job number to remove collisions
params='-c:v libvpx-vp9 -b:v 0 -crf 30 -passlogfile ffmpeglog-parallel{#}'

# get mp4 files requiring conversion and send them to GNU parallel to distribute
# ffmpeg jobs
ls assets/portfolio/*.mp4 | parallel --will-cite --verbose "ffmpeg -i {} $params -pass 1 -an -f null /dev/null && ffmpeg -y -i {} $params -pass 2 -c:a libopus {.}.webm"
