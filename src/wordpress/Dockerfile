FROM ubuntu:jammy
LABEL maintainer "Pascal Martineau <pascal@websimple.com>"

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apache2 vlogger \
    apt-transport-https build-essential ca-certificates gnupg software-properties-common \
    curl git less nano openssh-client rsync wget \
    language-pack-fr-base tzdata \
    && locale-gen fr_CA.utf8 \
    && rm -rf /var/lib/apt/lists/*

# Install PHP
RUN add-apt-repository ppa:ondrej/php \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php php-curl php-dev php-intl php-mbstring php-mysql php-pear php-xdebug php-xml php-zip \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY config/ /

# Configure Apache2
RUN set -ex \
    && . /etc/apache2/envvars \
    && a2enconf conf-extra fqdn mjs robots \
    && a2enmod expires headers remoteip rewrite vhost_alias \
    && a2disconf other-vhosts-access-log \
    && a2ensite vhosts \
    && a2dissite 000-default default-ssl \
    && sed -e '/Options Indexes FollowSymLinks/ s/^#*/#/' -i /etc/apache2/apache2.conf \
    && chsh --shell /bin/bash www-data \
    && apache2ctl graceful

# Configure Node.js
RUN npm install -g \
    pnpm yarn

# Configure PHP
RUN phpenmod xdebug

# Install composer / wp-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -sS https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

VOLUME ["/etc/apache2/conf-extra","/var/www/html","/var/log/apache2","/tmp"]
WORKDIR /var/www
EXPOSE 80
CMD ["/docker-entrypoint.sh"]
