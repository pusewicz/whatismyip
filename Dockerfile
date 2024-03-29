# syntax = docker/dockerfile:experimental

ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION} as base

ARG BUNDLER_VERSION=2.5.6
ARG RUBYGEMS_VERSION=3.5.6

ARG RACK_ENV=production
ENV RACK_ENV=${RACK_ENV}

ENV PATH $PATH:/usr/local/bin

ARG BUNDLE_WITHOUT=development:test
ARG BUNDLE_PATH=vendor/bundle
ENV BUNDLE_PATH ${BUNDLE_PATH}
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

SHELL ["/bin/bash", "-c"]

RUN mkdir /app
WORKDIR /app
RUN mkdir -p tmp/pids

FROM base as build

ENV DEV_PACKAGES build-essential

RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y ${DEV_PACKAGES} \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

RUN gem update --system ${RUBYGEMS_VERSION}
RUN gem install -N bundler -v ${BUNDLER_VERSION}

COPY Gemfile* .ruby-version ./
RUN bundle install && rm -rf vendor/bundle/ruby/*/cache

COPY . .

ARG RUBYGEMS_VERSION
ARG BUNDLER_VERSION
FROM base

RUN gem update --system ${RUBYGEMS_VERSION}
RUN gem install -N bundler -v ${BUNDLER_VERSION}

RUN groupadd -g 2000 yourip \
    && useradd -m -u 2001 -g yourip yourip

COPY --from=build /app /app

ARG GIT_REVISION
ENV GIT_REVISION=$GIT_REVISION
RUN echo $GIT_REVISION > /app/REVISION

RUN chown -R yourip:yourip /app

USER yourip

ENV PORT 8080

ENTRYPOINT ["/app/bin/docker-entrypoint"]
EXPOSE 8080
CMD ["./bin/puma", "-C", "config/puma.rb"]
