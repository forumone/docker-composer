# About this Image

Images built from this repository are parallel implementations of the Docker Hub's [`library/composer`](https://hub.docker.com/_/composer) image.

These images include a small utility, `install-php-extensions`, to simplify the task of installing common extensions. For example, to install SOAP, one only needs to add this to their Dockerfile:
```sh
# Install the core SOAP extension
RUN install-php-extensions soap
````

## Versions and Tags

* Supported PHP versions: 8.3, 8.2, 8.1
* Supported Composer versions: 2.8, 2.7, 2.6, 2.5, 2.4, 2.3, 2.2

Tags are constructed using `${COMPOSER_VERSION}-php-${PHP_VERSION}`. For example, Composer 2.8 running on PHP 8.3 is `2.8-php-8.3`.

The `2-` tag will generally always represent the latest 2.x version of Composer.

## License

Like the [base Composer image](https://github.com/composer/docker) we use, this project is available under the MIT license. See [LICENSE](LICENSE) for more details.
