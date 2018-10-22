#!/bin/bash
 
TOPDIR=$(dirname $0)
cd $TOPDIR && TOPDIR=$PWD
 
# Generate certificates if not existing
DESTDIR="$TOPDIR/data/certs"
APP_FQDN=$(hostname -f)
 
[[ -d $DESTDIR ]] || mkdir -p $DESTDIR
 
APP_GEN_CERT='openssl req -x509 -nodes -days 365 -newkey rsa:2048'
APP_GEN_CERT="$APP_GEN_CERT -keyout $DESTDIR/ldap.key -out $DESTDIR/ldap.crt"
APP_GEN_CERT="$APP_GEN_CERT -subj '/CN=$APP_FQDN/OU=TestOU/O=Organization/L=Location/ST=State/C=Country'"
APP_GEN_CERT="[[ -f $DESTDIR/ldap.crt ]] || $APP_GEN_CERT"
 
eval $APP_GEN_CERT
 
ln -s /etc/openldap/sldap.conf /root/openldap/data/slapd.conf

# Run docker-compose command
echo "Starting slapd..."
exec "$@"