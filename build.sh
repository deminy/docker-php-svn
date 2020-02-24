#!/usr/bin/env bash
#
# To build and push Docker images of different combination of PHP and Subversion versions.
#

set -e

usage()
{
cat << EOF
usage: $0

This script builds a Docker image with specific versions of PHP and Subversion.

OPTIONS:
   -h | --help    Show this message
   -p | --push    Push the image to the Docker Hub registry (optional)

Sample commands:

    # To build image "deminy/php-svn" (the default image name) with specific versions of PHP and Subversion.
    PHP_VERSION=7.4   SVN_VERSION=1.13.0 ./build.sh
    PHP_VERSION=7.4.3 SVN_VERSION=1.13.0 ./build.sh

    # To build and push image "deminy/php-svn" (the default image name) with specific versions of PHP and Subversion.
    PHP_VERSION=7.4   SVN_VERSION=1.13.0 ./build.sh -p
    PHP_VERSION=7.4.3 SVN_VERSION=1.13.0 ./build.sh -p

    # To build and push image "deminy/customized-image-name" with specific versions of PHP and Subversion.
    PHP_VERSION=7.4   SVN_VERSION=1.13.0 IMAGE_NAME=deminy/customized-image-name ./build.sh -p
    PHP_VERSION=7.4.3 SVN_VERSION=1.13.0 IMAGE_NAME=deminy/customized-image-name ./build.sh -p
EOF
}

DOCKER_PUSH=
while :; do
    case $1 in
        -h|-\?|--help)
            usage
            exit
            ;;
        -p|--push)
            DOCKER_PUSH=true
            ;;
        --) # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *) # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

if [ -z "${PHP_VERSION}" ] ; then
    echo "Error: environment variable 'PHP_VERSION' is empty or not set."
    echo "       Please run command '$0 -h' to see help information."
    exit 1
fi
if [ -z "${SVN_VERSION}" ] ; then
    echo "Error: environment variable 'SVN_VERSION' is empty or not set."
    echo "       Please run command '$0 -h' to see help information."
    exit 1
fi
if [ -z "${IMAGE_NAME}" ] ; then
    IMAGE_NAME=deminy/php-svn
fi

echo "Building image ${IMAGE_NAME}:php-${PHP_VERSION}-svn-${SVN_VERSION}."

sed "s/%%PHP_VERSION%%/${PHP_VERSION}/g" Dockerfile.tpl > Dockerfile
docker build \
    --no-cache \
    --build-arg SVN_VERSION=${SVN_VERSION} \
    -t "${IMAGE_NAME}:php-${PHP_VERSION}-svn-${SVN_VERSION}" .

if [ "${DOCKER_PUSH}" = "true" ] ; then
    echo "Pushing image ${IMAGE_NAME}:php-${PHP_VERSION}-svn-${SVN_VERSION}"
    docker push "${IMAGE_NAME}:php-${PHP_VERSION}-svn-${SVN_VERSION}"
    echo "Done building and pushing image ${IMAGE_NAME}:php-${PHP_VERSION}-svn-${SVN_VERSION}."
else
    echo "Done building image ${IMAGE_NAME}:php-${PHP_VERSION}-svn-${SVN_VERSION}."
    echo "To push the image built to the Docker Hub registry, please run following command:"
    echo "    docker push ${IMAGE_NAME}:php-${PHP_VERSION}-svn-${SVN_VERSION}"
fi
