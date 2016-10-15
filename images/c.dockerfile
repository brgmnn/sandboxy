FROM sandboxy:base

RUN apk add libc-dev clang

ADD entrypoints/c.sh /entrypoint.sh
