06/02/2025
---------
- Changes the base PHP image to be the Forum One php-cli image.
  - Updates the image to no use `bookworm` instead of `bullseye`.
  - Updates to provide additional PHP extensions required for some Composer package installation.
- Updates the `Dockerfile` to reduce build times and image sizes.
- Drops on-going support for PHP 8.0.

05/06/2024
----------
- Updated Docker image to convert from alpine to debian

03/19/2024
----------
- Added composer 2.7
- Added php 8.3
