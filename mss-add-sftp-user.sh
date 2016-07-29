#!/bin/bash
# Add FTP user with MySecureShell
if [ $(id -u) -eq 0 ]; then
   read -p "Enter username : " username
   read -s -p "Enter password : " password
   bshell='/usr/bin/mysecureshell'
   egrep "^$username" /etc/passwd >/dev/null
   if [ $? -eq 0 ]; then
       echo "$username exists!"
       read -n1 -r -p "Press space to continue..." key
       exit 1
   else
       pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
       useradd -m -s $bshell $username -p $pass
       [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed    to add a user!"
   fi
else
   echo "Only root may add a user to the system"
   exit 2
fi
read -n1 -r -p "Press space to continue..." key
