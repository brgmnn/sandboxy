FROM ubuntu

RUN apt-get update -qq

RUN mkdir /app
#RUN useradd -s /usr/sbin/nologin -r -M -d /app user

WORKDIR /app
