FROM alpine:3.4

RUN apk update -q && \
    mkdir /app

#RUN useradd -s /usr/sbin/nologin -r -M -d /app user

WORKDIR /app
