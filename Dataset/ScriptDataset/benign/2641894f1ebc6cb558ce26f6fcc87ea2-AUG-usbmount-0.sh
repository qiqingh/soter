#!/bin/sh
if [ $ACTION == "add" ]
then
storage_daemon add $1
elif [ $ACTION == "remove" ]
then
storage_daemon remove $1
fi
