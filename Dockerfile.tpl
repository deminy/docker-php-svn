FROM php:%%PHP_VERSION%%-cli

# We accept build parameter SVN_VERSION and make it persistent in the Docker image.
# @see https://docs.docker.com/engine/reference/builder/#arg
ARG SVN_VERSION
ENV SVN_VERSION $SVN_VERSION

# We force to update the serf download URL for Subversion 1.9.4 and older since the link is broken.
# @see https://svn.haxx.se/dev/archive-2016-11/0011.shtml Re: get-deps.sh: Serf Links Broken
# @see https://github.com/apache/subversion/commit/7497ebb9ef407c299aa7ac8a073a45086e580e8e
RUN \
  apt-get update  && \
  apt-get install -y \
    libapr1-dev      \
    libaprutil1-dev  \
    libsqlite3-dev   \
    libssl1.0-dev    \
    libtool          \
    libtool-bin      \
    libzip-dev       \
    python           \
    scons            \
    unzip            \
    zip              \
    zlib1g-dev    && \
  docker-php-ext-install zip && \
  curl -LO https://github.com/apache/subversion/archive/${SVN_VERSION}.tar.gz && \
  tar -zxvf ${SVN_VERSION}.tar.gz  && \
  cd subversion-${SVN_VERSION}     && \
  sed -i -e 's#http://serf.googlecode.com/svn/src_releases#https://archive.apache.org/dist/serf#g' ./get-deps.sh && \
  ./get-deps.sh serf               && \
  cd serf                          && \
  scons install                    && \
  cd ..                            && \
  ./autogen.sh                     && \
  LDFLAGS="-Wl,-rpath,/usr/local/lib" ./configure --with-lz4=internal --with-utf8proc=internal --with-serf && \
  make                             && \
  make install                     && \
  cd ..                            && \
  rm -rf subversion-${SVN_VERSION} ${SVN_VERSION}.tar.gz && \
  curl                    \
    -sf                   \
    --connect-timeout 5   \
    --max-time         15 \
    --retry            5  \
    --retry-delay      2  \
    --retry-max-time   60 \
    http://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
  composer --version && \
  php --version      && \
  svn --version

WORKDIR /docker-php-svn
