FROM jekyll/jekyll
LABEL org.opencontainers.image.source https://github.com/guppy0130/website

ENV GEM_HOME "/usr/local/bundle"
ENV GEM_PATH "/usr/local/bundle"

RUN apk del imagemagick-dev && apk add imagemagick6-dev ffmpeg parallel \
    util-linux git-lfs

# Add gemfile + lock
ADD Gemfile /srv/jekyll
ADD Gemfile.lock /srv/jekyll
# I guess you can override this with your own cache?
RUN bundle install --jobs `getconf _NPROCESSORS_ONLN`
