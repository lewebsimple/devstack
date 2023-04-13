FROM ubuntu:jammy
LABEL maintainer "Pascal Martineau <pascal@websimple.com>"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apache2 \
    apt-transport-https build-essential ca-certificates gnupg software-properties-common \
    curl git less nano openssh-client rsync wget \
    language-pack-fr-base tzdata \
    && locale-gen fr_CA.utf8 \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ondrej/php \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php php-curl php-dev php-intl php-mbstring php-mysql php-pear php-xdebug php-xml php-zip \
    && rm -rf /var/lib/apt/lists/*

COPY config/ /

RUN set -ex \
    && . /etc/apache2/envvars \
    && a2enconf fqdn conf-extra \
    && a2enmod expires headers remoteip rewrite vhost_alias \
    && a2ensite vhosts \
    && sed -e '/Options Indexes FollowSymLinks/ s/^#*/#/' -i /etc/apache2/apache2.conf \
    && rm /etc/apache2/sites-available/default-ssl.conf \
    && apache2ctl graceful

VOLUME ["/etc/apache2/conf-extra","/var/www/html","/tmp"]

CMD ["/docker-entrypoint.sh"]
