#!/bin/bash

#Script to check puppet master from a server
#Script Name: puppet_checker.sh
#Author: Zenitram

#Sends a command to a list of servers
#Requires 1 ip/host per line in the server list and the command to be sent
#For example 

#server list file name
serverlist=$1
user=mbueso
cmd1="$(cat /etc/system-release | grep "7." | wc -l)";
cmd2="$(cat /etc/system-release | grep "6." | wc -l)";
cmd3="$(cat /etc/puppetlabs/puppet/puppet.conf | grep "master1" | wc -l)";
cmd4="$(cat /etc/puppetlabs/puppet/puppet.conf | grep "masterap" | wc -l)";

#Greetings
echo "Hi $user"
echo "Today is $date"

#Validate the input server list name
if [ "$*" == ""]; then
    echo "Requires a serverlist and command. example: ./puppet-checker.sh serverlist command";
    echo "For multiple commands use quotes and ; example: \"command1; command2; command3\"";
    exit 1
fi

#For loop throught the server list
for server in $(cat $serverlist)
do
    cmdres:"$(ssh -qt $user@$server)"; #cmdres: "$(ssh -qt $user@$server "$cmd"); 
{

#Functions to check inside every VM
#checking the OS version on the VM
function os_check(){
    echo "#######-OS_Checker-#######"
    echo "The VM $server is running on: "
    if [ "$cmd1" -ne 0 ]; then
        echo "Centos 7"
    elif [ "$cmd2" -ne 0 ]; then 
        echo "Centos 6"
    else
        echo "Something went wrong"
    fi
    echo "#########################"
}

#checking the puppet server to which the VM is conected
function puppet_check() {
    echo "#######-Puppet_Checker-#######"
    echo "The VM $server is under puppet master: "
    if [ "$cmd3" -ne 0 ]; then
        echo "New Puppet"
    elif [ "$cmd4" -ne 0 ]; then
        echo "Old Puppet"
    else
        echo "Something went wrong"
    fi
    echo "##############################"
}

function all_checks() {
    os_check
    puppet_check
}

all_checks