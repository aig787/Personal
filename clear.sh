#!/bin/bash
echo "Clearing bash history..."
 > ~/.bash_history
echo "Removing known and authorized ssh hosts..."
rm ~/.ssh/known_hosts
rm ~/.ssh/authorized_keys
echo "Emptying trash..."
rm -rf ~/.local/share/Trash/files/*
rm -rf ~/.local/share/Trash/info/*
rm -rf ~/.local/share/Trash/expunged/*
echo "Restarting ssh server..."
sudo service ssh restart
echo "Reconfiguring iptables..."
./configure-iptables.sh
echo "Change password now? (y/n)"
read change
if [ $change == "y" ]; then
	passwd
fi
echo "Change root password now? (y/n)"
read change
if [ $change == "y'" ]; then
	sudo paswd
fi
