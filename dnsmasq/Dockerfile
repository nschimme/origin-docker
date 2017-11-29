FROM ubuntu:latest

RUN apt-get update && apt-get install -y dnsmasq

ADD dnsmasq.conf /dnsmasq-template.conf
ADD start-dnsmasq.sh /usr/bin/
RUN echo "conf-dir=/etc/dnsmasq.d/,*.conf" >> /etc/dnsmasq.conf
CMD ["start-dnsmasq.sh"]

