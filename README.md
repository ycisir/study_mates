![License](https://img.shields.io/badge/license-MIT-green.svg)

# StudyMates
Built a SaaS-based collaborative e-learning platform to enable real-time interaction and content sharing.

### Features
- Role-based authentication system
- Account activation & password recovery (email)
- User follow/unfollow relationships
- Real-time messaging (Action Cable)
- Room-based collaboration system
- Topic-based filtering
- Personalized activity feed
- Search, pagination & SEO-friendly URLs

### Tech Stack
**Backend**
- Ruby on Rails 7.2
- Ruby 3.2+
- MVC Architecture
- Hotwire (Turbo, Stimulus)

**Database**
- PostgreSQL (Neon in production, Docker in development)

**Real-time**
- Action Cable (WebSockets)
- Redis (Upstash in production, Docker in development)

**Email**
- SendGrid SMTP

**Deployment**
- Render

### Architecture
- Real-time messaging via Action Cable + Redis pub/sub
- Secure authentication (activation + password reset tokens)
- Docker-based local development environment

### Database schema
```mermaid
erDiagram

  USERS ||--o{ ROOMS : creates
  USERS ||--o{ MESSAGES : writes
  USERS ||--o{ RELATIONSHIPS : follows
  USERS ||--o{ ROOMS_USERS : joins

  ROOMS ||--o{ MESSAGES : has
  ROOMS }o--|| TOPICS : belongs_to

  USERS {
    bigint id
    string name
    string email
    boolean activated
  }

  ROOMS {
    bigint id
    string name
    bigint user_id
    bigint topic_id
  }

  TOPICS {
    bigint id
    string name
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

### Local Development
Docker handles PostgreSQL and Redis — no local installation required

**Prerequisites**
- Docker Compose

**Setup**
```bash
# clone the repository
git clone https://github.com/ycisir/study_mates.git

# move to project directory
cd study_mates

# rename .env.example to .env and change EMAIL_FROM in .env
mv .env.example .env

# build docker image
docker compose up --build

# run tests
docker compose exec web rails test
```
server runs at `http://127.0.0.1:3000/`

### License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for full details.