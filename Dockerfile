FROM harbor.ctn.prevnet/library/golang:alpine
EXPOSE 8080
COPY ./hello-app /usr/local/bin/
CMD ["hello-app"]
