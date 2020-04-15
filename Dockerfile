FROM golang:alpine

### Vars
ENV APPUSER appuser
ENV APPDIR /app
ENV APPPORT 8080

### Create App User
RUN if [ `getent passwd | grep ${APPUSER} | wc -l` -eq 0 ] \
    ; then \
             addgroup -g 1000 ${APPUSER} \
             && adduser -u 1000 -G ${APPUSER} -s /bin/sh -D ${APPUSER} \
    ; fi


WORKDIR ${APPDIR}

COPY ./app /app/

RUN chown -R ${APPUSER}. ${APPDIR}

USER ${APPUSER}

EXPOSE ${APPPORT}

ENTRYPOINT ./app
