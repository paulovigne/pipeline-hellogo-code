FROM n231d018803.fast.prevnet/library/nginx:latest

###
### Variables
###

### NGINX Vars
ENV NGINX_CONFDIR /etc/nginx/conf.d
ENV NGINX_BASEDIR /opt/app/nginx
ENV NGINX_HOMEDIR ${NGINX_BASEDIR}/helloworld

###
### Install Process
###

### Site Install

# Install Prereqs
#RUN apk add --no-cache bash

# Creating base site dir
RUN mkdir -p ${NGINX_HOMEDIR} 

# Deploying site build
COPY index.html ${NGINX_HOMEDIR}/
# Creating Site Virtual Host
COPY helloworld.conf ${NGINX_CONFDIR}/
# Removing default config
RUN rm -f ${NGINX_CONFDIR}/default.conf
