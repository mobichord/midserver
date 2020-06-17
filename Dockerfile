### ServiceNow MidServer ###

FROM debian
MAINTAINER andrii.pravdyvyi@mobichord.com
LABEL "application"="midserver"

COPY  ./agent  /opt/agent/
COPY  ./config/  /opt/


RUN  apt-get update \
     && apt-get -y install procps supervisor \
     && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD [ "/usr/bin/supervisord", "-c", "/opt/supervisord.conf"]
