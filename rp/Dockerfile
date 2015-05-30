FROM gliderlabs/alpine:3.2
MAINTAINER Jacob Evans jacob@dekz.net
ENV DOCKER_GEN_VERSION 0.3.9
ENV DOCKER_ARCH i386
ENV DOCKER_HOST unix:///var/run/docker.sock

RUN apk --update add wget bash ca-certificates

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-$DOCKER_ARCH-$DOCKER_GEN_VERSION.tar.gz && tar xvzf docker-gen-linux-$DOCKER_ARCH-$DOCKER_GEN_VERSION.tar.gz -C /usr/local/bin

RUN wget -P /usr/local/bin https://github.com/dekz/forego/releases/download/dev/forego \
 && chmod u+x /usr/local/bin/forego

RUN apk --update add nginx

RUN mkdir /app
WORKDIR /app

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD . /app
CMD ["forego", "start", "-r"]
