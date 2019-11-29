FROM n231d018803.fast.prevnet/nginx:latest

###
### Variables
###

### NGINX Vars
ENV NGINX_CONFDIR /etc/nginx/conf.d
ENV NGINX_VHOSTNAME hellworld
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
RUN echo -e $'server {\n\
\n\
    server_name '${NGINX_SRVNAME}';\n\
    root '${NGINX_HOMEDIR}';\n\
\n\
    location / {\n\
        try_files $uri /index.html;\n\
    }\n\
}' > ${NGINX_CONFDIR}/${NGINX_VHOSTNAME}.conf \
&& rm -f ${NGINX_CONFDIR}/default.conf
