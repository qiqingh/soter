
    # set first_use_date if not already set
    ret=`syscfg get first_use_date`
    if [ -z "$ret" ]; then
       syscfg set first_use_date "0001-01-01T00:00:00Z"
    fi

    # set OUI = Organization Unique ID
    ret=`skuapi -g hw_mac_addr`
    MAC=`echo $ret | awk -F"= " '{print $2}'`
    OUI=`echo $MAC | awk -F":" '{print $1$2$3}'`
    syscfg set OUI $OUI

   # set the serial number
   SN=`syscfg get device serial_number`
   if [ -z "$SN" ] ; then
      echo "Warning : No device serial number found in configuration database" > /dev/console
      echo "TODO : Create real serial number in 01_init.sh" > /dev/console
      SN="70149333423"
   fi

   # set the default hostname
   CURRENT_HOSTNAME=`syscfg get hostname`
   if [ -z "$CURRENT_HOSTNAME" ] ; then
      POS=`echo ${#SN}` 
      POS=`expr $POS - 5`
      HOSTNAME=`eval echo ${SN:${POS}}`
      # some apps (like zebra) complain if the hostname starts with a number, 
      # so append Cisco
      PREFIX=`syscfg get wl_ssid_prefix`
      if [ -n "$HOSTNAME" ] ; then
         HOSTNAME=$PREFIX${HOSTNAME}
      else
         HOSTNAME=$PREFIX${SSID}
      fi
      syscfg set hostname $HOSTNAME
      COMMIT=1
   fi

   if [ -n "$COMMIT" ] ; then
      syscfg commit
   fi

   # prepare time and timezone settings
   TZ=`syscfg get TZ`
   if [ -n "$TZ" ] ; then
      echo "export setenv TZ=$TZ" >> /etc/profile
   else
      echo "export setenv TZ=UTC" >> /etc/profile
   fi
