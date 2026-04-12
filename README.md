# StudyMates
Developing a SaaS-based collaborative e-learning platform

### Features
- Role based user management
- User relationships (follow/unfollow)
- Rooms management
- Authentication
- Account activation
- Password reset
- Authorization
- Real time messaging
- Activity
- Topic based rooms filtering
- Search functionality
- Pagination
- Personalized content feed

### Prerequisites
- PostgreSQL
- Rbenv (Ruby environment manager)
- Redis
- Ruby 3.2.1

### Local setup
```bash
git clone https://github.com/ycisir/study_mates.git
cd study_mates
bundle install
rails db:drop db:create db:migrate db:seed
# -------------------------------------------------------------------------
# if made any changes in css or js files make sure run these two commands
rails assets:clobber && rails assets:precompile
# -------------------------------------------------------------------------
rails t && rails s
```
Server runs at `http://127.0.0.1:3000/`