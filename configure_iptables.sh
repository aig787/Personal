#!/bin/bash
echo "Current iptables configuration..."
iptables -L
echo "Wiping current configuration..."
iptables -F
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I INPUT 1 -i lo -j ACCEPT
echo "Protecting against SSH brute force..."
iptables -A INPUT -i eth0.103 -p tcp -m tcp --dport 22 -m state --state NEW -m recent --set --name SSH --rsource
iptables -A INPUT -i eth0.103 -p tcp -m tcp --dport 22 -m recent --rcheck --seconds 30 --hitcount 4 --rttl --name SSH --rsource -j REJECT --reject-with tcp-reset
iptables -A INPUT -i eth0.103 -p tcp -m tcp --dport 22 -m recent --rcheck --seconds 30 --hitcount 3 --rttl --name SSH --rsource -j LOG --log-prefix "SSH brute force " --log-level 4
iptables -A INPUT -i eth0.103 -p tcp -m tcp --dport 22 -m recent --update --seconds 30 --hitcount 3 --rttl --name SSH --rsource -j REJECT --reject-with tcp-reset
iptables -A INPUT -i eth0.103 -p tcp -m tcp --dport 22 -j ACCEPT
echo "Accepting web traffic..."
iptables -A INPUT -p tcp -m tcp --dport 80 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -m state --state NEW -j ACCEPT
echo "Dropping all other traffic..."
iptables -A INPUT -j LOG
iptables -A INPUT -j DROP
echo "Successfully configured!"
iptables -L
echo "Attempting to install iptables-persistent and start the service..."
iptables-save > /etc/iptables/rules.v4
apt-get install iptables-persistent
service iptables-persistent start
