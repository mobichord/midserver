# midserver
ServiceNow MidServer - Docker

*ServiceNow docs:*
https://docs.servicenow.com/bundle/orlando-servicenow-platform/page/product/mid-server/concept/mid-server-installation.html

# Docker
Start docker container
```
docker run -d --name=midserver \
       -v /opt/midserver/logs:/opt/agent/logs \ 
        --env-file .env  \
       -p 443:443 -p 80:80 mobichord/midserver:latest
```
Madatory variables
```
The following variables mandatory:
    SN_URL      - servicenow instance URL (test.service-now.com)
    SN_USERNAME - username 
    SN_PASSWORD - password for SN_USERNAME
    SN_MID_NAME - Name of mid server which it'll be displayed on the SN instance.
```

# CI/CD

github action is used for ci/cd.
