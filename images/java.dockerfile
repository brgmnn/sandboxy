FROM sandboxy:base

RUN apk add openjdk8

ENV PATH=/usr/lib/jvm/default-jvm/bin:$PATH \
	JAVA_HOME=/usr/lib/jvm/default-jvm
