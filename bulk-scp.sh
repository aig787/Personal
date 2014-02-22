#!/bin/bash
# input should be stored in hosts.txt and files.txt
# usage: username hosts.txt files.txt
hosts="$1"
files="$2"
echo "Please enter your username:"
read -s username
while read -r line
do
	host="$line"
	while read -r line
	do
		echo "Copying $file to $host"
		file="$line"
		scp $file $username@$host:~/$file
	done < "$files"
done < "$hosts"
