### ServiceNow MidServer ###

FROM debian
MAINTAINER andrii.pravdyvyi@mobichord.com
LABEL "application"="midserver"

COPY  ./agent  /opt/agent/
COPY  ./config/entrypoint.sh  /usr/local/bin/entrypoint.sh

RUN  apt-get update \
     && apt-get -y install procps \
     && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/opt/agent/bin/wrapper-linux-x86-64", "-c", "/opt/agent/conf/wrapper.conf", "wrapper.java.maxmemory=512", "wrapper.syslog.ident=mid"]
