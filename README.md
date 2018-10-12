# Docker Image deminy/php-svn

[![License](https://poser.pugx.org/deminy/docker-php-svn/license)](https://github.com/deminy/docker-php-svn)

Dockerized test environments with different combination of PHP and Subversion versions built.

The Docker images have following software included:

* [Apache Subversion](http://subversion.apache.org)
* [PHP CLI](http://php.net/manual/en/features.commandline.php)
* [Composer](https://getcomposer.org)

There are different combination of PHP and Subversion versions built. All available combinations can be found [here](https://hub.docker.com/r/deminy/php-svn/).

## Docker Pull Commands

```bash
docker pull deminy/php-svn:php-7.0-svn-1.8.19
docker pull deminy/php-svn:php-7.1-svn-1.9.9
docker pull deminy/php-svn:php-7.2-svn-1.10.3
```

## Docker Build and Push Commands

```bash
# To build images with all predefined versions of PHP and Subversion.
./build.sh

# To build and push images with all predefined versions of PHP and Subversion.
./build.sh -p

# To build an image with specific versions of PHP and Subversion.
PHP_VERSION=7.0 SVN_VERSION=1.8.19 ./build.sh
PHP_VERSION=7.1 SVN_VERSION=1.9.9  ./build.sh
PHP_VERSION=7.2 SVN_VERSION=1.10.3 ./build.sh

# To build and push an image with specific versions of PHP and Subversion.
PHP_VERSION=7.2 SVN_VERSION=1.10.3 ./build.sh -p
```

## References

* [List of available Subversion releases](https://github.com/apache/subversion/releases)
* [Official Docker repository of PHP](https://hub.docker.com/_/php/)
