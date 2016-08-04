FROM sandboxy:base

RUN apt-get install -y nodejs npm

RUN npm install -g underscore
