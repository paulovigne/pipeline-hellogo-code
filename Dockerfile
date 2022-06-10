# builder image
# FROM golang:1.16-alpine3.14 as builder-goapp
FROM bitnami/golang:1.16 as builder-goapp
RUN mkdir /build
ADD ./server.go /build/
WORKDIR /build
RUN GOPATH=/build CGO_ENABLED=0 GOOS=linux go build server.go

# generate clean, final image for end users
# FROM alpine:3.14
FROM registry.access.redhat.com/ubi8-minimal:8.5-230

### Node Vars
ENV APPUSER appuser
ENV UIDGID 1001
ENV APP_BASEDIR /app
ENV APP_PORT 8080

# Add User
RUN microdnf install -y shadow-utils \
 && groupadd -g ${UIDGID} ${APPUSER} \
 && adduser ${APPUSER} -u ${UIDGID} -g ${UIDGID}
 
# RUN if [ `getent passwd | grep ${APPUSER} | wc -l` -eq 0 ] \
#     ; then \
#              addgroup -g ${UIDGID} ${APPUSER} \
#              && adduser -u ${UIDGID} -G ${APPUSER} -s /bin/sh -D ${APPUSER} \
#     ; fi \
#     && apk -U upgrade

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
