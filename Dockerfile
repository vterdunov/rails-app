FROM ruby:2.3.0-alpine
MAINTAINER Terdunov Vyacheslav <mail2slick@gmail.com>

ENV APP_HOME /usr/src/app
ENV BUILD_PACKAGES \
  ruby-dev \
  build-base \
  nodejs \
  tzdata \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  postgresql-dev \
  sqlite-dev

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
COPY Gemfile.lock $APP_HOME

RUN bundle config build.nokogiri --use-system-libraries && \
  bundle install --jobs=4

COPY . $APP_HOME
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
