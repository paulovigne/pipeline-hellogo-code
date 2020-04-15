FROM harbor.ctn.prevnet/library/golang:latest
EXPOSE 8080
COPY ./hello-app /usr/local/bin/
CMD ["hello-app"]
