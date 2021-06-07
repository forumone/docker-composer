# About this Image

Images built from this repository are parallel implementations of the Docker Hub's [`library/composer`](https://hub.docker.com/_/composer) image,
but they are built on top of PHP 7.4 to sidestep dependency resolution issues with the community image being built on PHP 8.

Images with Composer `1.10` are built with [hirak/prestissimo](https://packagist.org/packages/hirak/prestissimo) pre-installed globally.

## Composer Versions and Tags

Currently, we build the following versions of Composer:

- `2.1`, `2`, `latest`
- `1.10`, `1`

## License

Like the [base Composer image](https://github.com/composer/docker) we use, this project is available under the MIT license. See [LICENSE](LICENSE) for more details.
