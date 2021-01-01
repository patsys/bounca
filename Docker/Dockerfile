FROM alpine:3
MAINTAINER Patrick Weber "docker@patweber.de"

LABEL io.k8s.description="ApacheDS" \ 
      io.k8s.display-name="ApacheDS"


ENV BOUNCA_VERSION=bounca
ENV BOUNCA_SRC=bounca
ENV BOUNCA_SRVHOME=/srv/www
ENV BOUNCA_SRVPROJ=/srv/www/bounca

RUN apk add --no-cache \
  python3 \
  python3-dev \
  py3-pip \
  musl-dev \
  gcc \
  git \
  libffi-dev \
  postgresql-dev \
  libpq && \
  pip3 install --no-cache --upgrade pip setuptools




RUN git clone --branch master https://github.com/repleo/bounca.git $BOUNCA_SRVPROJ

COPY requirements.txt $BOUNCA_SRVPROJ/requirements.txt

# Install Python dependencies
RUN cd $BOUNCA_SRVPROJ &&  python3 -m venv venv/ && source venv/bin/activate &&  pip3 install -r $BOUNCA_SRVPROJ/requirements.txt

RUN mkdir -p  $BOUNCA_SRVHOME/media $BOUNCA_SRVHOME/static /srv/www/bounca/bounca/static $BOUNCA_SRVHOME/logs

RUN cd $BOUNCA_SRVPROJ \
  &&  python3 -m venv venv/ && source venv/bin/activate \
  && find ./webapp/templates/bounca  -name "**.html"  -type f -exec sh -c 'sed -i "s/load staticfiles/load static/g" "$0"' {} \; &&  python3 /srv/www/bounca/manage.py collectstatic --noinput

FROM alpine:3  
ENV BOUNCA_SRC=bounca \
    PRE_START_PATH=/app/prestart \
    DB_USER=postgres \
    DB_PWD=postgres \
    DB_HOST=postgres \
    DB_NAME=postgres \
    SMTP_HOST=localhost \
    ADMIN_MAIL=admin@localhost \
    FROM_MAIL=no-reply@localhost
RUN apk --no-cache add \
  nginx \
  uwsgi \
  postgresql-dev \
  libpq \
  python3 \
  py3-pip \
  py3-virtualenv \
  gettext \
  uwsgi-python3 \
  supervisor

COPY --from=0 /srv/www/bounca/ /var/www/bounca

RUN mkdir -p /etc/bounca && rm /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /opt/entrypoint
COPY conf/bounca.ini /var/templates/bounca/main.ini
COPY conf/vhost.conf /etc/nginx/conf.d/bounca.conf
COPY conf/uwsgi.ini /etc/uwsgi/conf.d/bounca.ini
COPY conf/supervisord.ini /etc/supervisor.d/supervisord.ini

RUN adduser -S www-data -G www-data \
  && chown -R www-data:www-data /var/www/bounca \
  && chown -R nginx:nginx /var/www/bounca/media \
  && touch /var/www/bounca/init-setup

ENTRYPOINT ["/opt/entrypoint"]
EXPOSE 80
