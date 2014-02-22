#!/bin/bash
echo "Clearing bash history..."
 > ~/.bash_history
echo "Removing known ssh hosts..."
rm ~/.ssh/known_hosts
echo "Emptying trash..."
rm -rf ~/.local/share/Trash/files/*
rm -rf ~/.local/share/Trash/info/*
rm -rf ~/.local/share/Trash/expunged/*
echo "Restarting ssh server..."
sudo service ssh restart
ok="y"
while [ $ok != "n" ]
do
	echo "Suggested password is $(openssl rand -base64 12)"
	echo "Regenerate password (y/n)?"
	read ok
done
passwd
