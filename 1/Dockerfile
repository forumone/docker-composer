FROM composer:1.10.22 AS composer

FROM php:7.4.10-cli-alpine

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
ENV COMPOSER_VERSION 1.10.22

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install the prestissimo plugin to speed operations on Composer 1.
RUN composer global require hirak/prestissimo

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]
