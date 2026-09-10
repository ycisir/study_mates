# Study Mates
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
rails t && rails s
```

### License
This project is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.