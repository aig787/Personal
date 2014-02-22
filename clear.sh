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
echo "Change password now? (y/n)"
read change
if [ $change == "y" ]; then
	ok="y"
	while [ $ok != "n" ]; do
		echo "Suggested password is $(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_++{}|:<>?=' | fold -w 12 | head -n 1)"
		echo "Regenerate password? (y/n)"
		read ok
	done
	passwd
fi
