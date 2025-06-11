ARG COMPOSER_VERSION
ARG PHP_VERSION

FROM composer:${COMPOSER_VERSION} AS composer

FROM public.ecr.aws/forumone/php-cli:${PHP_VERSION}

# Dependencies copied from the community composer image.
# See https://github.com/composer/docker/blob/master/1.10/Dockerfile.
RUN set -eux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    coreutils \
    git \
    make \
    openssh-client \
    patch \
    tini \
    unzip \
    zip \
  && rm -rf /var/lib/apt/lists/*

RUN printf "# composer php cli ini settings\n\
  date.timezone=UTC\n\
  memory_limit=-1\n\
  " > $PHP_INI_DIR/php-cli.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION ${COMPOSER_VERSION}

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]
