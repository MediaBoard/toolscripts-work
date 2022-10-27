#!/bin/bash

#Script to check cname on Linux Servers
#Script Name: cname-checker.sh
#Author: Zenitram
#Check DNS records for a l;ist of servers
#Requires at least 1 server to validate records

#Requirements
user=mbueso
server=$1

#DIG commands with cname option
cmd1="dig -t CNAME /$1 @172.16.7.126"; #Toronto Linux
cmd2="dig -t CNAME /$1 @172.20.7.126"; #Vancouver Linux
cmd3="dig -t CNAME /$1 @172.16.238.101"; #Toronto Windows
cmd4="dig -t CNAME /$1 @172.16.238.110"; #Vancouver Windows

#Greetings
echo "Hi $user"
echo "Today is $date"
