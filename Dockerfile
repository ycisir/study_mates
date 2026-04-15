FROM ruby:3.2.1

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]