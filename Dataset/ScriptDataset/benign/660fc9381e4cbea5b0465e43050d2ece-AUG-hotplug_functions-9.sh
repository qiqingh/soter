    MODEL=`syscfg get device modelNumber`
    if [ -n "$MODEL" ] ; then 
      PRODUCT_STRING="product=\"${MODEL}\""
    fi
    MODULE_PATH=/lib/modules/`uname -r`/
    insmod -q ${MODULE_PATH}/sxuptp_wq.ko
    insmod -q ${MODULE_PATH}/sxuptp.ko netif=br0
    insmod -q ${MODULE_PATH}/sxuptp_driver.ko
    insmod -q ${MODULE_PATH}/jcp.ko $PRODUCT_STRING
    ulog usb manager "add_virtualusb_drivers() $PRODUCT_STRING"
