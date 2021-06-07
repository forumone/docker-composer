FROM composer:2.1.1 AS composer

FROM php:8.0.7-cli-alpine

# Dependencies copied from the community composer image.
# See https://github.com/composer/docker/blob/master/1.10/Dockerfile.
RUN set -eux; \
  apk add --no-cache --virtual .composer-rundeps \
  bash \
  coreutils \
  git \
  make \
  mercurial \
  openssh-client \
  patch \
  subversion \
  tini \
  unzip \
  zip

RUN printf "# composer php cli ini settings\n\
  date.timezone=UTC\n\
  memory_limit=-1\n\
  " > $PHP_INI_DIR/php-cli.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 2.0.14

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]
