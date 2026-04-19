FROM ruby:3.2.1

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libvips \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0 -p 3000"]