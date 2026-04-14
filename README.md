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

### Database schema
```mermaid
erDiagram

  USERS ||--o{ ROOMS : "creates (host)"
  USERS ||--o{ MESSAGES : "writes"
  USERS ||--o{ RELATIONSHIPS : "follows/followed"
  USERS ||--o{ ROOMS_USERS : "joins"

  ROOMS ||--o{ MESSAGES : "has"
  ROOMS }o--o{ USERS : "participants"
  ROOMS }o--|| TOPICS : "belongs to"

  MESSAGES }o--|| USERS : "author"
  MESSAGES }o--|| ROOMS : "belongs to"

  RELATIONSHIPS }o--|| USERS : "follower"
  RELATIONSHIPS }o--|| USERS : "followed"

  ROOMS_USERS }o--|| USERS : "member"
  ROOMS_USERS }o--|| ROOMS : "room"


  USERS {
    bigint id
    string name
    string email
    string slug
    boolean admin
    boolean activated
  }

  ROOMS {
    bigint id
    string name
    text info
    bigint user_id
    bigint topic_id
    string slug
  }

  TOPICS {
    bigint id
    string name
    string slug
  }

  MESSAGES {
    bigint id
    text body
    bigint user_id
    bigint room_id
  }

  RELATIONSHIPS {
    bigint follower_id
    bigint followed_id
  }

  ROOMS_USERS {
    bigint room_id
    bigint user_id
  }
  ```

### Prerequisites
- PostgreSQL
- Rbenv
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

### License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for full details.