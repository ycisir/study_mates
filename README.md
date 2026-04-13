![License](https://img.shields.io/badge/license-MIT-green.svg)

# StudyMates
Built a SaaS-based collaborative e-learning platform to enable real-time interaction and content sharing.

### Features
- Role based user management
- User relationships (follow/unfollow)
- Rooms management
- Authentication and Authorization
- Account activation and Password reset email
- Real time messaging
- Recent activity and Topic based rooms filtering
- Search functionality and Pagination
- Personalized content feed
- SEO friendly URL

### Prerequisites
- PostgreSQL (Should be installed on local machine)
- Rbenv (Ruby environment manager)
- Redis (Should be installed on local machine)
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

### License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for full details.