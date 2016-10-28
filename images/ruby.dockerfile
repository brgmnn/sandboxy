FROM sandboxy:base

RUN apk add ruby

ADD entrypoints/ruby.sh /entrypoint.sh
