# StudyMates
Developing a SaaS-based collaborative e-learning platform

### Features
- Role based user management
- User relationships (follow/unfollow)
- Rooms CRUD
- Authentication
- Account activation
- Authorization
- Real time messaging
- Activity
- Topic based rooms filtering
- Search functionality
- Pagination
- Personalized content feed

### Prerequisites
- Rbenv (Ruby environment manager)
- Ruby 3.2.1
- Redis
- SQLite

### Local setup
```bash
git clone https://github.com/ycisir/study_mates.git
cd study_mates
bundle install
rails db:drop db:create db:migrate db:seed
rails t
rails s
```
Server runs at `http://127.0.0.1:3000/`

### Assumptions
- SQLite used for simplicity