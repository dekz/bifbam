FROM ubuntu:trusty
MAINTAINER Jacob Evans jacob@dekz.net
ENV DOCKER_GEN_VERSION 0.3.6

RUN apt-get update && apt-get install -y wget bash

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz && tar xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz -C /usr/local/bin
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

RUN mkdir /app
WORKDIR /app

RUN apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD . /app
CMD ["forego", "start", "-r"]
