FROM ruby:2.6-alpine
RUN apk update
RUN apk upgrade
RUN apk add tzdata
RUN apk add build-base nodejs postgresql-dev yarn
RUN apk add --no-cache bash
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
RUN rails webpacker:install
ADD . /myapp

#CMD ["rails", "server", "-b", "0.0.0.0"]