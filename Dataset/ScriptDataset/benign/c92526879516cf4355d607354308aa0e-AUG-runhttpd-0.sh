#! /bin/sh

# brief : separate mini-http relative script into this file.

# 2005.04.27  Wesley Lee     Initial version

THIS=`basename $0`
BINDIR=`echo $0 | sed "s/\/$THIS\$//"`
if [ "$BINDIR" = "" ]; then
    BINDIR="."
fi

HTTPD=mini_httpd
###########################################################
# mini_httpd settings
###########################################################
MINI_ARG="-d ${BINDIR}/../www -c **.cgi -p 80"
MINI_ARG="${MINI_ARG} -i /var/run/$HTTPD.pid"
MINI_ARG="${MINI_ARG} -l /var/log/$HTTPD.log -u root -D"

case $1 in
    start)
       start
       ;;
    stop)
       stop
       ;;
    *)
       echo "Usage : $0 {start | stop}"
       exit 1
esac
