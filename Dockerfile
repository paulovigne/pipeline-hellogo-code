FROM harbor.ctn.prevnet/library/golang:latest
EXPOSE 8080
COPY ./hello-app /usr/local/bin/
USER 1001
CMD ["hello-app"]
