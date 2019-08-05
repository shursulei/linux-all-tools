#!/bin/bash

username=$1
password=$2
lusername=`whoami`
lipaddr=`hostname -i`
while read line
do
if [ $lipaddr = $line -a $lusername = $username ];then
continue
else
./keysetup.exp $line $username $password $lusername
fi
done < sshhosts