#!/bin/sh
set -e
envsubst </var/templates/bounca/main.ini >/var/www/bounca/etc/bounca/main.ini
envsubst </var/templates/bounca/bounca.yaml >/var/www/bounca/etc/bounca/services.yaml
mkdir -p /run/nginx $PRE_START_PATH /run/uwsgi/app/bounca/
chown -R www-data:www-data /run/uwsgi/app/bounca/

# If there's a prestart.sh script in the /app directory, run it before starting
find $PRE_START_PATH -prune -path "*.sh" -type f -exec sh -c '"$0"' {} \;
cd  /var/www/bounca  && source venv/bin/activate && python3 manage.py migrate --noinput && deactivate

# Start Supervisor, with Nginx and uWSGI
exec /usr/bin/supervisord
