# Study Mates

[![CI](https://github.com/ycisir/study_mates/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/ycisir/study_mates/actions/workflows/ci.yml)
![Ruby](https://img.shields.io/badge/Ruby-3.4.8-red) ![Rails](https://img.shields.io/badge/Rails-8.0-red) ![Tests](https://img.shields.io/badge/line%20coverage-91%25-brightgreen)

A collaborative learning platform for real-time discussion, messaging and knowledge sharing.

**Live demo:** [YOUR-RENDER-URL] (the free tier can take about 30 seconds to wake up)

### Features
* Authentication with account activation & password recovery
* Follow / unfollow users + personalized feed
* Real-time messaging and activity updates using Action Cable (WebSockets)
* Topic-based rooms for structured discussions
* Search, pagination and SEO-friendly URLs
* Admin panel

### Technology Stack
* Ruby on Rails, Hotwire, Stimulus, Postgres, Redis, Action Cable, Cloudinary, SendGrid, Render

### Setup
**Prerequisites**
- rbenv (ruby 3.4.8)
- rails 8.0.5
- postgres
- redis (for development)
- libvips (active storage)

```bash
git clone https://github.com/ycisir/study_mates.git
cd study_mates
bundle install
rails db:setup
bin/rails server
```

### Testing
```bash
bundle exec rspec
```
- Specs cover models, requests, channels, jobs and mailers.
- A coverage report is generated at `coverage/index.html` (SimpleCov, line and branch coverage).
- Tests don't need Redis, because Action Cable uses the test adapter.
- GitHub Actions runs RSpec against PostgreSQL, plus RuboCop and Brakeman, on every pull request.

### License
This project is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.