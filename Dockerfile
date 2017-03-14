FROM alpine:3.5

RUN apk --update add \
      ca-certificates \
      ruby \
      make \
      build-base \
      zlib-dev \
      ruby-bundler \
      ruby-io-console \
      musl-dev \
      zlib zlib-dev \
      libxml2 libxml2-dev \
      libxslt libxslt-dev \
      ruby-dev \
      ruby-libs \
      libffi libffi-dev \
      nodejs && \
    rm -rf /var/cache/apk/*

ADD . /opt/middleman-app
WORKDIR /opt/middleman-app

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
RUN bundle exec middleman build

EXPOSE 5000

CMD bundle exec puma -p 5000 config.ru
