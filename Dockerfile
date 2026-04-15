FROM ruby:3.2.1

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bash", "-c", "set -e && bundle exec rails assets:precompile && bundle exec rails db:migrate && bundle exec rails db:seed && bundle exec rails server -b 0.0.0.0 -p 3000"]