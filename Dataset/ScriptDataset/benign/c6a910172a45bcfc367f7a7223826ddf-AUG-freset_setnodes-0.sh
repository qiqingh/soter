#!/bin/sh
echo [$0] > /dev/console
#Set default NetBios name to dlinkapwwyy 
MAC=`mfc getlanmac`
N5=`echo $MAC | cut -d: -f5`
N6=`echo $MAC | cut -d: -f6`
DEFNETBIOS="dlinkap$N5$N6"
rgdb -s /netbios/name $DEFNETBIOS


