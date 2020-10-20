    WAN_MTU=$SYSCFG_wan_mtu
    if [ "" = "$WAN_MTU" ] || [ "0" = "$WAN_MTU" ] ; then
      case "$SYSCFG_wan_proto" in
        dhcp | static)
          WAN_MTU=1500
          DEF_WAN_MTU=$WAN_MTU
          ;;
        pppoe)
          WAN_MTU=1492
          DEF_WAN_MTU=`expr $WAN_MTU + 8`
          ;;
        pptp | l2tp)
          WAN_MTU=1460
          DEF_WAN_MTU=`expr $WAN_MTU + 40`
          ;;
        dslite)
          WAN_MTU=1460
          DEF_WAN_MTU=`expr $WAN_MTU + 40`
          ;;
        *)
          ulog wan status "$PID called with incorrect wan protocol $SYSCFG_wan_proto. Aborting"
          return 3
          ;;
        esac
    else
      case "$SYSCFG_wan_proto" in
        dhcp | static)
          if [ "$WAN_MTU" -gt 1500 ]; then
             WAN_MTU=1500
          fi
          DEF_WAN_MTU=$WAN_MTU
          ;;
        pppoe)
          if [ "$WAN_MTU" -gt 1492 ]; then
             WAN_MTU=1492
          fi
          DEF_WAN_MTU=`expr $WAN_MTU + 8`
          ;;
        pptp | l2tp)
          if [ "$WAN_MTU" -gt 1460 ]; then
             WAN_MTU=1460
          fi
          DEF_WAN_MTU=`expr $WAN_MTU + 40`
          ;;
        dslite)
          if [ "$WAN_MTU" -gt 1460 ]; then
             WAN_MTU=1460
          fi
          DEF_WAN_MTU=`expr $WAN_MTU + 40`
          ;;
        *)
          echo "[utopia] wanControl.sh error: called with incorrect wan protocol " $SYSCFG_wan_proto > /dev/console
          return 3
          ;;
      esac
    fi
    case "$SYSCFG_wan_proto" in
      pppoe | pptp | l2tp)
        WAN_BSS=`expr $WAN_MTU - 40`
        sysevent set ppp_clamp_mtu $WAN_BSS
        ;;
      dslite)
        echo "[utopia] Not setting ppp_clamp_mtu on dslite protocol" > /dev/console
        ;;
      *)
         echo "[utopia] Not setting ppp_clamp_mtu" > /dev/console
        ;;
    esac
   if [ -n "$SYSEVENT_current_wan_ifname" -a "dslite" != "$SYSEVENT_current_wan_ifname" ] ; then
      ip -4 link set $SYSEVENT_current_wan_ifname mtu $DEF_WAN_MTU
   fi
   return 0
