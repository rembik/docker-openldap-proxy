#!/bin/bash

TOPDIR=$(dirname $0)
cd $TOPDIR && TOPDIR=$PWD

# Generate certificates if not existing
DESTDIR="$TOPDIR/certs"
APP_FQDN=$(hostname -f)

[[ -d $DESTDIR ]] || mkdir -p $DESTDIR

APP_GEN_CERT='openssl req -x509 -nodes -days 365 -newkey rsa:2048'
APP_GEN_CERT="$APP_GEN_CERT -keyout $DESTDIR/privkey.pem -out $DESTDIR/cert.pem"
APP_GEN_CERT="$APP_GEN_CERT -subj '/CN=$APP_FQDN/OU=TestOU/O=Organization/L=Location/ST=State/C=Country'"
APP_GEN_CERT="[[ -f $DESTDIR/cert.pem ]] || $APP_GEN_CERT"

eval $APP_GEN_CERT

# Link custom configuration
ln -s /root/openldap/data/slapd.conf /etc/openldap/sldap.conf

# Run docker-compose command
echo "Starting slapd..."
exec "$@"