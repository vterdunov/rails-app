FROM ruby:2.3

MAINTAINER Terdunov Vyacheslav <mail2slick@gmail.com>

RUN apt-get update -qq && \
  apt-get install -y build-essential libxml2-dev libxslt1-dev nodejs

ENV APP_HOME /usr/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#ADD Gemfile* $APP_HOME/
#RUN bundle install

ADD . $APP_HOME

