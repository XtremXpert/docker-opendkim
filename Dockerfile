FROM debian:latest

MAINTAINER Benoît "XtremXpert" Vézina  <xtremxpert@xtremxpert.com>

ENV DEBIAN_FRONTEND=noninteractive \
  MAIL_DOMAIN=xtremxpert.com \
  MAIL_MX_DOMAIN=poste.$MAIL_DOMAIN \
  MAIL_DKIM_SELECTOR=mail \
  MAIL_POSTMASTER=postmaster@$MAIL_DOMAIN \
  VIMBADMIN_DOMAIN=vimbadmin.$MAIL_DOMAIN \
  VIMBADMIN_SUPERUSER=admin@$MAIL_DOMAIN \
  VIMBADMIN_SUPERUSER_PASSWORD=%AUTOGEN_PASSWORD% \
  VIMBADMIN_REMEMBERME_SALT=%AUTOGEN_SALT% \
  VIMBADMIN_PASSWORD_SALT=%AUTOGEN_SALT% \
  ROUNDCUBE_DOMAIN=webmail.$MAIL_DOMAIN

RUN apt-get update \
&& apt-get install --no-install-recommends -y opendkim opendkim-tools 

COPY rootfs /

RUN chmod a+x /opt/confd
RUN chmod a+x /opt/start.sh

EXPOSE 12301
CMD ["/opt/start.sh"]
