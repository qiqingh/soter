    
    MOUNT_DIR=`sysevent get usb_device_mount_pt_${1}`
    
    if [ ! -z "$MOUNT_DIR" ] && [ -e ${MOUNT_DIR} ] ; then
      drv="`echo $MOUNT_DIR | sed "s/\/tmp\///g"`"
      ulog usb manager "unmount and remove existed storage $drv on usb_port $1"
      `$STORAGE_DEVICE_SCRIPT remove $drv $1`
    fi
