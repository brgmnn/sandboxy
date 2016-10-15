FROM sandboxy:base

RUN apk add python

ADD entrypoints/python.sh /entrypoint.sh
