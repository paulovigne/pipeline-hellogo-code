# builder image
FROM quay.io/bitnami/golang as builder-goapp
RUN mkdir /build
ADD ./server.go /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -o server .

# generate clean, final image for end users
FROM registry.access.redhat.com/ubi8-minimal:8.5-230

### Node Vars
ENV APPUSER appuser
ENV APP_BASEDIR /app
ENV APP_PORT 8080

# Creating node user, install basic packages

RUN if [ `getent passwd | grep ${APPUSER} | wc -l` -eq 0 ] \
    ; then \
             addgroup -g 1001 ${APPUSER} \
             && adduser -u 1001 -G ${APPUSER} -s /bin/sh -D ${APPUSER} \
    ; fi \
    && apk -U upgrade

# Install App
RUN mkdir ${APP_BASEDIR}
WORKDIR ${APP_BASEDIR}
COPY --from=builder-goapp /build/server .

# Change Owner
RUN chown -R ${APPUSER}. ${APP_BASEDIR}

# Set User
USER ${APPUSER}

# ports
EXPOSE ${APP_PORT}

# executable
CMD [ "./server" ]
