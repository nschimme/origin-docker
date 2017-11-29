#!/bin/bash

get_ip() {
  interface=$(ip route | grep default | awk '{print $(NF)}')
  ip addr show dev $interface | grep 'inet ' | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | head -n 1

}

get_dns_ip() {
  cat /etc/resolv.conf |grep -i '^nameserver'|head -n1|cut -d ' ' -f2
}

[[ -z $HOST_IP ]] && export HOST_IP=$(get_ip) &&  echo "\$HOST_IP not set - using $HOST_IP"
[[ -n $HOST_IP ]] || (echo "\$HOST_IP not set and couldn't detect it. Bailing hard." && exit 1)
[[ -z $UPSTREAM_DNS_IP ]] && export UPSTREAM_DNS_IP=$(get_dns_ip) && echo "\$UPSTREAM_DNS_IP not set - using $UPSTREAM_DNS_IP"
[[ -n $UPSTREAM_DNS_IP ]] || (echo "\$UPSTREAM_DNS_IP not set and couldn't detect it. Bailing hard." && exit 1)

docker rm -f cache_dnsmasq
docker run -it -d --restart=always -e "HOST_IP=$HOST_IP" -e "UPSTREAM_DNS_IP=$UPSTREAM_DNS_IP" -p 53:53 -p 53:53/udp --name cache_dnsmasq dnsmasq
