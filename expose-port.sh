#!/bin/bash

echo "Jumphost Remote access configuration"

_API_PORT='443'
_SRC_IF='ens3'
_DST_IF='ens4'

echo '* Activate kernel routing'
sysctl -w net.ipv4.ip_forward=1

echo '* Flush Current IPTables settings'
iptables --flush
iptables --delete-chain
iptables --table nat --flush
iptables --table nat --delete-chain

echo '* Activate default forwarding'

iptables -P FORWARD ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

echo '* Activate masquerading'

iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
iptables -t nat -A POSTROUTING -o ens4 -j MASQUERADE

echo '* Activate eAPI forwarding with base port 800x'

# Switch
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8001 -j DNAT --to-destination 10.73.254.1:443
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8002 -j DNAT --to-destination 10.73.254.2:443
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8003 -j DNAT --to-destination 10.73.254.3:443
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8004 -j DNAT --to-destination 10.73.254.4:443
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8005 -j DNAT --to-destination 10.73.254.5:443
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8006 -j DNAT --to-destination 10.73.254.6:443
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8007 -j DNAT --to-destination 10.73.254.7:443
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8008 -j DNAT --to-destination 10.73.254.8:443

# Firewall
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport  8101 -j DNAT --to-destination 10.73.254.101:443

iptables -A FORWARD -p tcp -d 10.73.254.0/24 --dport ${_API_PORT} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

echo "-> Configuration done"