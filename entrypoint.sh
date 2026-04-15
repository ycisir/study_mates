#!/bin/bash
set -e

rm -f tmp/pids/server.pid

bundle exec rails db:prepare

exec bundle exec rails s -b 0.0.0.0 -p 3000