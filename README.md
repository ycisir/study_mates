# StudyMates
A SaaS-based collaborative e-learning platform for real-time discussion, messaging, and knowledge sharing.

### ✨ Features
* 🔐 Authentication with account activation & password recovery
* 👥 Follow / unfollow users + personalized feed
* 💬 Real-time messaging using Action Cable (WebSockets)
* 🧠 Topic-based rooms for structured discussions
* 🔍 Search, pagination, and clean URLs

### 🛠 Tech Stack
* Ruby 3.2, Rails 7.2, Hotwire (Turbo), Postgres, Redis, Action Cable, Cloudinary(Serve media), SendGrid(Email), Render(Deploy)

### ⚙️ Setup
***Prerequisites***
- rbenv (Ruby 3.2+)
- postgres
- redis
- libvips

```bash
git clone https://github.com/ycisir/study_mates.git
cd study_mates
bundle install
rails db:setup
rails t && rails s
```

### 📄 MIT License