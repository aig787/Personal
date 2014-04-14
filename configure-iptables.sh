#!/bin/bash
#configures iptables to block against ssh brute force attacks and drop all other connections other than those already established
iptables -F
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I INPUT 1 -i lo -j ACCEPT
echo "Protecting against SSH brute force..."
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set --name SSH --rsource
iptables -A INPUT -p tcp --dport 22 -m recent --rcheck --seconds 30 --hitcount 4 --rttl --name SSH -j REJECT --reject-with tcp-reset
iptables -A INPUT -p tcp --dport 22 -m recent --rcheck --seconds 30 --hitcount 3 --rttl --name SSH --rsource -j LOG --log-prefix "SSH Brute Force "
iptables -A INPUT -p tcp --dport 22 -m recent --update --seconds 30 --hitcount 3 --rttl --name SSH --rsource -j REJECT --reject-with tcp-reset
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
read -p "Is this a web server? (y/n) " yn
if [ $yn == "y" ] || [ $yn == "Y" ]; then
	echo "Accepting web traffic..."
	iptables -A INPUT -p tcp -m tcp --dport 80 -m state --state NEW -j ACCEPT
	iptables -A INPUT -p tcp -m tcp --dport 443 -m state --state NEW -j ACCEPT
fi
echo "Dropping all other traffic..."
iptables -A INPUT -j LOG
iptables -A INPUT -j DROP
echo "Successfully configured!"
iptables -L
