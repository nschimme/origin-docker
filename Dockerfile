FROM ubuntu:latest

RUN apt-get update && apt-get install -y build-essential libssl-dev libpcre3 libpcre3-dev zlib1g zlib1g-dev wget

WORKDIR /build
ADD build.sh /build/

RUN	/build/build.sh		;\
	rm -rf /etc/nginx/conf.d/* /etc/nginx/sites-enabled/*

COPY cache_overlay/ /

CMD nginx -g "daemon off;" -c /etc/nginx/nginx.conf

