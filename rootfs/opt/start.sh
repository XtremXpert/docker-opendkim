#!/bin/sh

if [ -z "$DOMAIN" ]; then
    echo "DOMAIN environment variable is required"
    exit 1
fi

if [ -z "$SELECTOR" ]; then
    echo "DOMAIN environment variable is required"
    exit 1
fi

if ! [[ -f /etc/certs/dkim.private ]]; then
  echo "DKIM private key not found in data/certs, autogenerating..."

  mkdir -p /tmp/certs
  opendkim-genkey --testmode --domain=$MAIL_DOMAIN --selector=$MAIL_DKIM_SELECTOR --directory=/tmp/certs
  mv /tmp/certs/$MAIL_DKIM_SELECTOR.private /etc/certs/dkim.private
  mv /tmp/certs/$MAIL_DKIM_SELECTOR.txt /etc/certs/dkim.txt

  echo "Generated keys and DNS settings"
fi

sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/opendkim.conf
sed -i -e "s/%MAIL_DKIM_SELECTOR%/${MAIL_DKIM_SELECTOR}/g" /etc/opendkim.conf

# Make mail log to syslog
sed -i -e "s#/var/log/mail.log#/var/log/syslog#g" /etc/syslog-ng/syslog-ng.conf

# Have to copy cert to non-volume mounted folder or it causes permissions errors
cp /etc/certs/dkim.private /etc/ssl/certs/dkim.private

exec /usr/sbin/opendkim -f
