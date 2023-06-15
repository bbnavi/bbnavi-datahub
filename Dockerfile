FROM ruby:2.7-bullseye

RUN apt update
RUN apt install -y curl apt-transport-https ca-certificates
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt install -y nodejs
RUN apt install -y yarn
RUN apt install -y wget
RUN apt install -y libpq-dev
RUN apt clean
RUN rm -rf /var/lib/apt/lists/* /usr/src/*

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc
RUN chmod +x mc
RUN mv mc /bin
RUN mc -help

ENV DOCKERIZE_VERSION v0.6.1
RUN curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  | tar -C /usr/local/bin -xz

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN gem install bundler
RUN bundle config set --local without 'development test'
RUN bundle install

COPY . /app
RUN chmod +x bin/start-cron.sh
COPY docker/unicorn.rb /app/config/unicorn.rb
COPY docker/database.yml /app/config/database.yml

RUN bundle exec rake DATABASE_URL=nulldb://user:pass@127.0.0.1/dbname assets:precompile

ENTRYPOINT ["/app/docker/entrypoint.sh"]

VOLUME /unicorn
VOLUME /assets

# Start the main process.
CMD ["bundle", "exec", "unicorn", "-c", "./config/unicorn.rb"]
