#!/bin/bash
set -e

until nc -z -v -w30 db 3306
do
  echo 'Waiting for MySQL...'
  sleep 1
done
echo "MySQL is up and running!"

rm -f /app/tmp/pids/server.pid

mkdir -p public/css
chmod -R 777 public/css

exec foreman start -f Procfile.dev