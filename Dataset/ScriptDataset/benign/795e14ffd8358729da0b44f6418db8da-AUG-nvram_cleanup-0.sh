#!/bin/sh
NVDIRTY=0
NVKNOWN_LIST_FILE=/etc/nvram.cleanup.lst
NVTEMP_FILE=/tmp/.nvram.cleanup.tmp
rm -f $NVTEMP_FILE
nvram show 2> /dev/null | grep "^wl_"       | cut -d'=' -f1  >  $NVTEMP_FILE
nvram show 2> /dev/null | grep "^wl[0|1]_"  | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^wl[0|1]\." | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^wsc_"      | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^storage_"    | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^ftp_share_"  | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^MS_scan_"    | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^LOG_"        | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^filter_"     | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^ddns_"     | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^ppp"     | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^l2tp"     | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^qos_"     | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^get_pa2g"     | cut -d'=' -f1  >> $NVTEMP_FILE
nvram show 2> /dev/null | grep "^get_pa5g"     | cut -d'=' -f1  >> $NVTEMP_FILE
for i in `cat $NVTEMP_FILE`
do
    NVDIRTY=1
    nvram unset $i
done
if [ -f $NVKNOWN_LIST_FILE ]; then
    for i in `cat $NVKNOWN_LIST_FILE`
    do
        NVVAL=`nvram get $i`
        if [ "set" != "set$NVVAL" ]; then
            NVDIRTY=1
            nvram unset $i
        fi
    done
fi
if [ "1" = $NVDIRTY ]; then
    echo "[utopia][init]Please wait, vendor nvram is being cleaned up"
    nvram commit
fi
