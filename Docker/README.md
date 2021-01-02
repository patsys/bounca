## Not Working
* folder media/static/libs not existing so angular, bootstrap und co not working

## Require
* Postgresql Database >12

## BounCA Dockerfile

This repository contains **Dockerfile** of [BounCA](https://bounca.org/) for [Docker](https://www.docker.com/)'s (https://registry.hub.docker.com/u/patsys/bounca/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* alpine:3

### Environment Variable
| Name       | required | Description       | Default            |
|------------|----------|-------------------|--------------------|
| DB_USER    | *        | Database User     | postgresql         |
| DB_PWD     | *        | Database Password | postgresql         |
| DB_HOST    | *        | Database Host     | postgresql         |
| DB_NAME    | *        | Database Name     | postgresql         |
| SMTP_HOST  | -        | Smtp Host         | localhost          |
| ADMIN_MAIL | -        | Admin Email       | admin@localhost    |
| FROM_MAIL  | -        | Email send from   | no-reply@localhost |

## Todo
* Set Admin Password

