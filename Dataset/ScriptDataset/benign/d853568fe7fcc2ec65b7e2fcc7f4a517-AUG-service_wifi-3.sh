     SMB_ENA=`syscfg get smb_enabled`
     USB_COUNT=`sysevent get no_usb_drives`
     if [ ! "$USB_COUNT" ] ; then
        USB_COUNT=0
     fi
     if [ "$SMB_ENA" == "0" -o $USB_COUNT -eq 0 ] ; then
	    echo "${SERVICE_NAME}, smp wifi"
	    /bin/smp.sh wifi 2>/dev/null
     else
	    echo "${SERVICE_NAME}, smp do not optimize wifi."
     fi
