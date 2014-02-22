#!/bin/bash
hosts="$1"
echo "Please enter your username:"
read -s username
ssh-keygen -t rsa
ssh-add ~/.ssh/id_rsa
while read -r line
do
	host="$line"
	ssh-copy-id -i ~/.ssh/id_rsa.pub $username@$host
done < "$hosts"
