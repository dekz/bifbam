FROM ubuntu:trusty
MAINTAINER Jacob Evans jacob@dekz.net

RUN apt-get update && apt-get install -y wget bash dnsmasq psmisc

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.3.3/docker-gen-linux-amd64-0.3.3.tar.gz && tar xvzf docker-gen-linux-amd64-0.3.3.tar.gz -C /usr/local/bin
RUN mkdir /app

WORKDIR /app
ADD . /app
