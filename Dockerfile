FROM debian:latest

MAINTAINER Benoît "XtremXpert" Vézina  <xtremxpert@xtremxpert.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
&& apt-get install --no-install-recommends -qq -y opendkim opendkim-tools psmisc

COPY rootfs /

RUN chmod a+x /opt/confd
RUN chmod a+x /opt/start.sh

EXPOSE 12301
CMD ["/opt/start.sh"]
