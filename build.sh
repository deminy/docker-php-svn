#!/usr/bin/env bash
#
# To build and push Docker images of different combination of PHP and Subversion versions.
#
# Sample usage:
#     # To build images with predefined versions of PHP and Subversion.
#     ./build.sh
#     # To build and push images with predefined versions of PHP and Subversion.
#     ./build.sh -p
#     # To build an image with specific versions of PHP and Subversion.
#     PHP_VERSION=7.2 SVN_VERSION=1.10.3 ./build.sh
#     # To build and push an image with specific versions of PHP and Subversion.
#     PHP_VERSION=7.2 SVN_VERSION=1.10.3 ./build.sh -p
#

set -e

DOCKER_PUSH=
for var in "$@"; do
    if [ "${var}" = "-p" ] ; then
        DOCKER_PUSH=true
    fi
done

if [ -z "${PHP_VERSION}" ] ; then
    PHP_VERSIONS=("7.0" "7.1" "7.2")
else
    PHP_VERSIONS=("${PHP_VERSION}")
fi
if [ -z "${SVN_VERSION}" ] ; then
    SVN_VERSIONS=("1.8.19" "1.9.9" "1.10.3")
else
    SVN_VERSIONS=("${SVN_VERSION}")
fi

for PHP_VERSION in ${PHP_VERSIONS[@]} ; do
    for SVN_VERSION in ${SVN_VERSIONS[@]} ; do
        echo "Building image deminy/php-svn:php-${PHP_VERSION}-svn-${SVN_VERSION}"

        sed "s/%%PHP_VERSION%%/${PHP_VERSION}/g" Dockerfile.tpl > Dockerfile
        docker build \
            --no-cache \
            --build-arg SVN_VERSION=${SVN_VERSION} \
            -t "deminy/php-svn:php-${PHP_VERSION}-svn-${SVN_VERSION}" .

        if [ "${DOCKER_PUSH}" = "true" ] ; then
            echo "Pushing image deminy/php-svn:php-${PHP_VERSION}-svn-${SVN_VERSION}"
            docker push "deminy/php-svn:php-${PHP_VERSION}-svn-${SVN_VERSION}"
        fi

        echo "Done building (and pushing) image deminy/php-svn:php-${PHP_VERSION}-svn-${SVN_VERSION}"
    done
done

echo "Done building (and pushing) all the images for repository deminy/php-svn."
