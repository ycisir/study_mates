# Study Mates
[![CI](https://github.com/ycisir/study_mates/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/ycisir/study_mates/actions/workflows/ci.yml)
![Ruby](https://img.shields.io/badge/Ruby-3.4.8-red) ![Rails](https://img.shields.io/badge/Rails-8.0-red) ![Tests](https://img.shields.io/badge/line%20coverage-91%25-brightgreen)
A SaaS-based collaborative learning platform for real-time discussion, messaging and knowledge sharing.

### Features
* Authentication with account activation & password recovery
* Follow / unfollow users + personalized feed
* Real-time messaging and activity updates using Action Cable (WebSockets)
* Topic-based rooms for structured discussions
* Search, pagination and seo-friendly URLs
* Admin panel

### Technology Stack
* Ruby on Rails, Hotwire, Stimulus, Postgres, Redis, Action Cable, Cloudinary, SendGrid, Render

### Setup
**Prerequisites**
- rbenv (ruby 3.4.8)
- rails 8.0.5
- postgres
- redis
- libvips (active storage)

```bash
git clone https://github.com/ycisir/study_mates.git
cd study_mates
bundle install
rails db:setup
bundle exec rspec
```

### License
This project is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.