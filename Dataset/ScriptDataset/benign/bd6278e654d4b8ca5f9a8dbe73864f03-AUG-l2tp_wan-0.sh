#!/bin/sh
source /etc/init.d/ulog_functions.sh
source /etc/init.d/service_wan/ppp_helpers.sh
source /etc/init.d/service_wan/wan_helper_functions
LAN_IFNAME=`syscfg get lan_ifname`
PID="($$)"
SELF_NAME=l2tp_wan
L2TP_PEERS_DIRECTORY=/etc/ppp/peers
L2TP_CONF_DIR=/etc/l2tp
L2TP_CONF_FILE=$L2TP_CONF_DIR"/"l2tp.conf
L2TP_OPTIONS_DIR=/etc/ppp/peers
L2TP_OPTIONS_FILE=$L2TP_OPTIONS_DIR"/utopia-l2tp"
ulog l2tp_wan status "$PID ${NAMESPACE}_current_ipv4_link_state is $SYSEVENT_current_ipv4_link_state"
ulog l2tp_wan status "$PID ${NAMESPACE}_desired_ipv4_wan_state is $SYSEVENT_desired_ipv4_wan_state"
ulog l2tp_wan status "$PID ${NAMESPACE}_current_ipv4_wan_state is $SYSEVENT_current_ipv4_wan_state"
ulog l2tp_wan status "$PID wan_proto is $SYSCFG_wan_proto"
case "$EVENT" in
   current_ipv4_link_state)
      ulog l2tp_wan status "$PID ipv4 link state is $SYSEVENT_current_ipv4_link_state"
      if [ "up" != "$SYSEVENT_current_ipv4_link_state" ] ; then
         if [ "up" = "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog l2tp_wan status "$PID ipv4 link is down. Tearing down wan"
            bring_wan_down
         else
            ulog l2tp_wan status "$PID ipv4 link is down. Wan is already down"
            bring_wan_down
         fi
         exit 0
      else
         if [ "up" = "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog l2tp_wan status "$PID ipv4 link is up. Wan is already up"
            exit 0
         else
            if [ "up" = "$SYSEVENT_desired_ipv4_wan_state" ] ; then
                  bring_wan_up
                  exit 0
            else
               ulog l2tp_wan status "$PID ipv4 link is up. Wan is not requested up"
               exit 0
            fi
         fi
      fi
      ;;
   desired_ipv4_wan_state)
      if [ "up" = "$SYSEVENT_desired_ipv4_wan_state" ] ; then
         if [ "up" = "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog l2tp_wan status "$PID wan is already up."
            exit 0
         else
            if [ "up" != "$SYSEVENT_current_ipv4_link_state" ] ; then
               ulog l2tp_wan status "$PID wan up request deferred until link is up"
               exit 0
            else
               bring_wan_up
               exit 0
            fi
         fi
      else
         if [ "up" != "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog l2tp_wan status "$PID wan is already down. Bringing down again."
            bring_wan_down
         else
            bring_wan_down
         fi
      fi
      ;;
   config_l2tp_peers)
      prepare_l2tp_peers
      ;;
   *)
      ulog l2tp_wan status "$PID Invalid parameter $1 "
      exit 3
      ;;
esac
