# Docker Image deminy/php-svn

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/deminy/docker-php-svn/blob/master/LICENSE.txt)

Dockerized test environments with different combination of PHP and Subversion versions built.

The Docker images have following software included:

* [Apache Subversion](http://subversion.apache.org)
* [PHP CLI](http://php.net/manual/en/features.commandline.php)
* [Composer](https://getcomposer.org)

There are different combination of PHP and Subversion versions built. All available combinations can be found [here](https://hub.docker.com/r/deminy/php-svn/). You may pull the images like following:

```bash
docker pull deminy/php-svn:php-7.0-svn-1.8.19
docker pull deminy/php-svn:php-7.1-svn-1.9.9
docker pull deminy/php-svn:php-7.2-svn-1.10.3
docker pull deminy/php-svn:php-7.3-svn-1.11.0
# or, more specifically:
docker pull deminy/php-svn:php-7.1.19-svn-1.10.0
```

## Docker Build and Push Commands

```bash
# To build image "deminy/php-svn" (the default image name) with specific versions of PHP and Subversion.
PHP_VERSION=7.1    SVN_VERSION=1.10.0 ./build.sh
PHP_VERSION=7.1.19 SVN_VERSION=1.10.0 ./build.sh

# To build and push image "deminy/php-svn" (the default image name) with specific versions of PHP and Subversion.
PHP_VERSION=7.1    SVN_VERSION=1.10.0 ./build.sh -p
PHP_VERSION=7.1.19 SVN_VERSION=1.10.0 ./build.sh -p

# To build and push image "deminy/customized-image-name" with specific versions of PHP and Subversion.
PHP_VERSION=7.1    SVN_VERSION=1.10.0 IMAGE_NAME=deminy/customized-image-name ./build.sh -p
PHP_VERSION=7.1.19 SVN_VERSION=1.10.0 IMAGE_NAME=deminy/customized-image-name ./build.sh -p
```

## References

* [List of available Subversion releases](https://github.com/apache/subversion/releases)
* [Official Docker repository of PHP](https://hub.docker.com/_/php/)
