#!/bin/bash

[[ -n $HOST_IP ]] || (echo "\$HOST_IP not set. Cannot proceed :(" && exit 1)
[[ -n $UPSTREAM_DNS_IP ]] || (echo "\$UPSTREAM_DNS_IP not set. Cannot proceed :(" && exit 1)

[[ -f /etc/dnsmasq.d/custom-zones.conf ]] || (cat /dnsmasq-template.conf | sed "s/IP_HERE/$HOST_IP/" > /etc/dnsmasq.d/custom-zones.conf)
[[ -f /etc/resolv.dnsmasq.conf ]] || (cat /resolv-template.conf | sed "s/DNS_HERE/$UPSTREAM_DNS_IP/" > /etc/resolv.dnsmasq.conf)

exec dnsmasq --no-daemon


