#! /bin/sh

# brief : separate mini-http relative script into this file.

# 2005.04.27  Wesley Lee     Initial version

THIS=`basename $0`
BINDIR=`echo $0 | sed "s/\/$THIS\$//"`
if [ "$BINDIR" = "" ]; then
    BINDIR="."
fi

TMSSS=tmRatingd
HTTPCAP=tmHttpHook.a
###########################################################
# mini_httpd settings
###########################################################
TMSSS_ARG="-if eth1"

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
