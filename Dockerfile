# syntax = docker/dockerfile:experimental
ARG RUBY_VERSION=3.1.2
ARG VARIANT=jemalloc-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT} as base

ARG BUNDLER_VERSION=2.3.21

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

RUN gem install -N bundler -v ${BUNDLER_VERSION}

COPY Gemfile* .ruby-version ./
RUN bundle install &&  rm -rf vendor/bundle/ruby/*/cache

COPY . .

FROM base

COPY --from=build /app /app

ENV PORT 8080

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
