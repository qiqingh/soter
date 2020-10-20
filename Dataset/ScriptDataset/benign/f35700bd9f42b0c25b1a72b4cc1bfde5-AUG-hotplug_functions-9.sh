    MODEL=`syscfg get device modelNumber`
    if [ -n "$MODEL" ] ; then 
      PRODUCT_STRING="product=\"${MODEL}\""
    fi
    MODULE_PATH=/lib/modules/`uname -r`/
    insmod ${MODULE_PATH}/sxuptp_wq.ko
    insmod ${MODULE_PATH}/sxuptp.ko
    insmod ${MODULE_PATH}/sxuptp_driver.ko
    /usr/sbin/jcpd -f /etc/jcpd.conf
    ulog usb manager "add_virtualusb_drivers() $PRODUCT_STRING"
