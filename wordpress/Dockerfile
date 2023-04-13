FROM ubuntu:jammy
LABEL maintainer "Pascal Martineau <pascal@websimple.com>"

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apache2 \
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

# Copy configuration files
COPY config/ /

# Configure Apache2
RUN set -ex \
    && . /etc/apache2/envvars \
    && a2enconf fqdn conf-extra \
    && a2enmod expires headers remoteip rewrite vhost_alias \
    && a2ensite vhosts \
    && sed -e '/Options Indexes FollowSymLinks/ s/^#*/#/' -i /etc/apache2/apache2.conf \
    && rm /etc/apache2/sites-available/default-ssl.conf \
    && ln -sfT /dev/stderr "${APACHE_LOG_DIR}/error.log" \
    && ln -sfT /dev/stdout "${APACHE_LOG_DIR}/access.log" \
    && apache2ctl graceful

# Configure PHP
RUN phpenmod xdebug

# Install composer / wp-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -sS https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

VOLUME ["/etc/apache2/conf-extra","/var/www/html","/tmp"]

CMD ["/docker-entrypoint.sh"]
