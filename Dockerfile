FROM alpine:3.2
MAINTAINER Terdunov Vyacheslav <mail2slick@gmail.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base nodejs tzdata \
  libxml2-dev libxslt-dev libffi-dev postgresql-dev sqlite-dev
ENV RUBY_PACKAGES ruby ruby-io-console

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN gem install bundler --no-ri --no-rdoc && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install

COPY . /usr/app
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
