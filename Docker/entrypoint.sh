#!/bin/sh
envsubst </var/templates/bounca/main.ini >/etc/bounca/main.ini
mkdir -p /run/nginx $PRE_START_PATH /run/uwsgi/app/bounca/
chown -R www-data:www-data /run/uwsgi/app/bounca/
set -e

# If there's a prestart.sh script in the /app directory, run it before starting
find $PRE_START_PATH -prune -path "*.sh" -type f -exec sh -c '"$0"' {} \;

# Start Supervisor, with Nginx and uWSGI
cd /var/www/bounca
exec /usr/bin/supervisord
