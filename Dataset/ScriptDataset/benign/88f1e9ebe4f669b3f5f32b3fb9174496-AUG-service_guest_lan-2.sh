   max_ssidlen=32
   max_guest_ssid_prefix=`expr $max_ssidlen - ${#SYSCFG_guest_ssid_suffix}`
   if [ -n "$SYSCFG_wl0_ssid"  ]; then
      GUEST_SSID="${SYSCFG_wl0_ssid:0:$max_guest_ssid_prefix}$SYSCFG_guest_ssid_suffix"
      ulog guest_lan status "Guest SSID = $GUEST_SSID"
      ulog guest_lan status "Syscfg Guest SSID = $SYSCFG_guest_ssid"
      if [ "$SYSCFG_guest_ssid" != "$GUEST_SSID" ]; then
         utctx_cmd setsync guest_ssid="$GUEST_SSID"
         return 1;
      fi
   fi
   return 0;
