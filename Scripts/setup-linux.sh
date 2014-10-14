#!/bin/bash
#Script to configure Linux with secure initial setup
read -p "Change user password? (y/n) " yn
if [ $yn == "y" ] || [ $yn == "Y" ]; then
	passwd
fi
read -p "Change root password? (y/n) " yn
if [ $yn == "y" ] || [ $yn == "Y" ]; then
	sudo passwd
fi
read -p "Configure iptables? (y/n) " yn
if [ $yn == "y" ] || [ $yn == "Y" ]; then
	sudo ./configure-iptables.sh
	if [ -f /etc/debian_version ]; then
		echo "Saving iptables rules to /etc/iptables/rules.v4"
		sudo iptables-save > /etc/iptables/rules.v4
	else
		echo "Saving iptables rules to /etc/sysconfig/iptables"
		sudo iptables-save > /etc/sysconfig/iptables
	fi
fi
read -p "Patch SSH configuration? (y/n) " yn
if [ $yn == "y" ] || [ $yn == "Y" ]; then
	echo "Backing up current SSH configuration..."
	sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bk
	echo "Copying known good configuration..."
	sudo cp sshd_config /etc/ssh/sshd_config
fi
echo "PLEASE REMOVE UNNEEDED USERS (separated by spaces)"
cut -d: -f1 /etc/passwd
read -p "Enter users to remove: " users
if [ -f /etc/debian_version ]; then
	for user in $users
	do
		echo "Removing $user..."
		sudo deluser --remove-home $user
	done
else
	for user in $users
	do
		echo "Removing $user..."
		sudo userdel -r $user
	done
fi
echo "PLEASE KILL UNNEEDED/SUSPICOUS PROCESSES (separated by spaces)"
sudo lsof -i
read -p "Enter PID of processes to kill: " processes
for process in $processes
do
	echo "Killing $process..."
	sudo kill $process
done
./search-immutable.sh
echo "Finished!"
