#!/bin/sh

set -e

DB=${DB_HOST:-bbnavi-datahub-postgresql-staging:5432}

dockerize -wait tcp://$DB -timeout 30s

npm set audit false
bundle exec rake db:gis:setup
bundle exec rake db:migrate

bundle exec rake graphql:schema:dump
cp -r /app/public/* /assets/
rm -f /unicorn.pid

exec "$@"
