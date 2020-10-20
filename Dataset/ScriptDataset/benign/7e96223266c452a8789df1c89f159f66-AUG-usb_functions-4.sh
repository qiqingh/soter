    if [ -z "$1" ] ; then
      USB_friendly_name=
      USB_current_mode=
      return
    fi
    get_syscfg_UsbPortCount
    if [ "$1" -le "$SYSCFG_UsbPortCount" ] ; then
      USB="UsbPort_$1"
      eval `utctx_cmd get "$USB"`
      eval NS='$'SYSCFG_$USB
              ARGS="\
              $NS::friendly_name \
              $NS::current_mode" 
      utctx_batch_get "$ARGS"
      eval `echo USB_friendly_name='$'SYSCFG_${NS}_friendly_name`
      eval `echo USB_current_mode='$'SYSCFG_${NS}_current_mode`
      ulog usb manager "USB_current_mode = $USB_current_mode"
    else
      USB_friendly_name="System_${1}"
      USB_current_mode=unused
    fi
