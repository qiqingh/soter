    if [ -z "$1" ] ; then
      USB_desired_mode=
      return
    fi
    echo $* | grep -q virtualUSB;
    if [ "0" = "$?" ] ; then
      echo $* | grep -q storage
      if [ "0" = "$?" ] ; then
         USB_desired_mode="detect"
      else
         USB_desired_mode="virtualUSB"
      fi
    else
      echo $* | grep -q storage
      if [ "0" = "$?" ] ; then
         USB_desired_mode="storage"
      else 
         USB_desired_mode="$1"
      fi
    fi
