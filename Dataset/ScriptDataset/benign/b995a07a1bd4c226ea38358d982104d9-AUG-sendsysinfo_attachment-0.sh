#!/bin/sh
if [ ! -f /tmp/etc/ssmtp.conf ]; then
    cat > /tmp/etc/ssmtp.conf << eof
root=`syscfg get smtp.root`
mailhub=`syscfg get smtp.mailhub`
AuthUser=`syscfg get smtp.user`
AuthPass=`syscfg get smtp.pass`
UseSTARTTLS=`syscfg get smtp.usestarttls`
FromLineOverride=`syscfg get smtp.fromlineoverride`
eof
fi
SERIAL=`syscfg get device::serial_number`
MODEL=`syscfg get device::modelNumber`
SYSINFO_FILE="/tmp/sysinfo_$$.txt"
if [ ! -f $SYSINFO_FILE ]; then
    cwd=`pwd`
    cd /www
    ./sysinfo.cgi > $SYSINFO_FILE 2>/dev/null
    cd $cwd
fi
echo -e "From: noreply-dev@linksyssmartwifi.com\nSubject: Sysinfo from $MODEL Serial# $SERIAL\n\nAttached is sysinfo from `hostname`.\n\n" | \
(cat - && uuencode $SYSINFO_FILE sysinfo-$SERIAL.txt) | ssmtp -C /tmp/etc/ssmtp.conf $1
rm -f $SYSINFO_FILE
