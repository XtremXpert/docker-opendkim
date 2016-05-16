FROM debian:latest

MAINTAINER Benoît "XtremXpert" Vézina  <xtremxpert@xtremxpert.com>

ENV DEBIAN_FRONTEND=noninteractive \
  MAIL_DOMAIN=xtremxpert.com \
  MAIL_MX_DOMAIN=poste.$MAIL_DOMAIN \
  MAIL_DKIM_SELECTOR=poste \
  MAIL_POSTMASTER=postmaster@$MAIL_DOMAIN

RUN apt-get update \
&& apt-get install --no-install-recommends -y opendkim opendkim-tools 

COPY rootfs /

RUN chmod a+x /opt/start.sh

EXPOSE 12301

CMD ["/opt/start.sh"]
