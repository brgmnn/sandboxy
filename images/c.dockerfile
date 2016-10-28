FROM sandboxy:base

RUN apk update && \
    apk add libc-dev binutils build-base clang

ADD entrypoints/c.sh /entrypoint.sh
