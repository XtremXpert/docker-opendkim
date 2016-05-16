FROM debian:latest

MAINTAINER Benoît "XtremXpert" Vézina  <xtremxpert@xtremxpert.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
&& apt-get install --no-install-recommends -y opendkim opendkim-tools 

COPY rootfs /

RUN chmod a+x /opt/confd
RUN chmod a+x /opt/start.sh

EXPOSE 12301
CMD ["/opt/start.sh"]
