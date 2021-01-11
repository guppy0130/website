FROM jekyll/jekyll
LABEL org.opencontainers.image.source https://github.com/guppy0130/website

ENV GEM_HOME "/usr/local/bundle"
ENV GEM_PATH "/usr/local/bundle"

RUN apk del imagemagick-dev && apk add imagemagick6-dev ffmpeg parallel \
    util-linux

# Add gemfile + lock
ADD Gemfile /srv/jekyll
ADD Gemfile.lock /srv/jekyll
# I guess you can override this with your own cache?
RUN bundle install --jobs `getconf _NPROCESSORS_ONLN`

# apply patch for jekyll-responsive-image. This should be removed once #103 is
# merged. This box is guaranteed to have `git-apply`, but `patch -p1` could also
# be used.
RUN cd /usr/local/bundle/gems/jekyll-responsive-image-1.5.5 && \
    (wget -qO- https://patch-diff.githubusercontent.com/raw/wildlyinaccurate/jekyll-responsive-image/pull/103.patch | tail -n15 | git apply)
