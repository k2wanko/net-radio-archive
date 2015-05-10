FROM ruby:2.2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /app
WORKDIR /app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

# net-radio-archive dependencies
RUN echo "deb http://ftp.tsukuba.wide.ad.jp/Linux/ubuntu/ lucid main" >> /etc/apt/sources.list \
    && echo "deb-src http://ftp.tsukuba.wide.ad.jp/Linux/ubuntu/ lucid main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --force-yes rtmpdump ffmpeg swftools --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile /app/
COPY Gemfile.lock /app/
RUN bundle install
COPY . /app
