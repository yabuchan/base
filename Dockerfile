FROM owncloud/ubuntu:latest
MAINTAINER ownCloud DevOps <devops@owncloud.com>

VOLUME ["/mnt/data"]

EXPOSE 32180

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["/usr/local/bin/owncloud"]

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y \
    apache2 \
    libapache2-mod-php \
    php-gd \
    php-json \
    php-mysql \
    php-sqlite3 \
    php-pgsql \
    php-curl \
    php-intl \
    php-mcrypt \
    php-imagick \
    php-zip \
    php-xml \
    php-mbstring \
    php-soap \
    php-ldap \
    php-apcu \
    php-redis \
    smbclient \
    php-smbclient \
    mysql-client \
    postgresql-client \
    sqlite \
    gettext-base && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/apache2/sites-available/default-ssl.conf && \
  a2enmod rewrite headers env dir mime ssl expires && \
  mkdir -p /var/www/owncloud /mnt/data/files /mnt/data/config /mnt/data/certs /mnt/data/sessions && \
  chown -R www-data:www-data /var/www/owncloud /mnt/data && \
  chsh -s /bin/bash www-data

COPY rootfs /
WORKDIR /var/www/owncloud

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vcs-url="https://github.com/owncloud-docker/base.git"
LABEL org.label-schema.name="ownCloud Base"
LABEL org.label-schema.vendor="ownCloud GmbH"
LABEL org.label-schema.schema-version="1.0"

RUN sed -i -e 's/80/32180/g' /etc/apache2/ports.conf
