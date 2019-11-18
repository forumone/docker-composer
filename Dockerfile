ARG COMPOSER_VERSION
FROM composer:${COMPOSER_VERSION}

RUN composer global require hirak/prestissimo
