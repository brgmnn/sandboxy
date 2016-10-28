FROM sandboxy:base

RUN apk add nodejs-lts && \
    npm install underscore

ADD entrypoints/javascript.sh /entrypoint.sh
