#!/bin/sh
source /etc/init.d/ulog_functions.sh
source /etc/init.d/service_wan/ppp_helpers.sh
source /etc/init.d/service_wan/wan_helper_functions
PPTP_PEERS_DIRECTORY=/etc/ppp/peers
PPTP_TUNNEL_NAME=utopia-pptp
PPTP_PEERS_FILE=$PPTP_PEERS_DIRECTORY"/"$PPTP_TUNNEL_NAME
PPTP_BIN=/usr/sbin/pptp
LAN_IFNAME=`syscfg get lan_ifname`
PID="($$)"
SELF_NAME=pptp_wan
PPTP_OPTIONS_FILE=/etc/ppp/options.pptp
ulog pptp_wan status "$PID ${NAMESPACE}_current_ipv4_link_state is $SYSEVENT_current_ipv4_link_state"
ulog pptp_wan status "$PID ${NAMESPACE}_desired_ipv4_wan_state is $SYSEVENT_desired_ipv4_wan_state"
ulog pptp_wan status "$PID ${NAMESPACE}_current_ipv4_wan_state is $SYSEVENT_current_ipv4_wan_state"
case "$EVENT" in
   current_ipv4_link_state)
      ulog pptp_wan status "$PID ipv4 link state is $SYSEVENT_current_ipv4_link_state"
      if [ "up" != "$SYSEVENT_current_ipv4_link_state" ] ; then
         if [ "up" = "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog pptp_wan status "$PID ipv4 link is down. Tearing down wan"
            bring_wan_down
         else
            ulog pptp_wan status "$PID ipv4 link is down. Wan is already down"
            bring_wan_down
         fi
         exit 0
      else
         if [ "up" = "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog pptp_wan status "$PID ipv4 link is up. Wan is already up"
            exit 0
         else
            if [ "up" = "$SYSEVENT_desired_ipv4_wan_state" ] ; then
                  bring_wan_up
                  exit 0
            else
               ulog pptp_wan status "$PID ipv4 link is up. Wan is not requested up"
               exit 0
            fi
         fi
      fi
      ;;
   desired_ipv4_wan_state)
      if [ "up" = "$SYSEVENT_desired_ipv4_wan_state" ] ; then
         if [ "up" = "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog pptp_wan status "$PID wan is already up."
            exit 0
         else
            if [ "up" != "$SYSEVENT_current_ipv4_link_state" ] ; then
               ulog pptp_wan status "$PID wan up request deferred until link is up"
               exit 0
            else
               bring_wan_up
               exit 0
            fi
         fi
      else
         if [ "up" != "$SYSEVENT_current_ipv4_wan_state" ] ; then
            ulog pptp_wan status "$PID wan is already down. Bringing down again."
            bring_wan_down
         else
            bring_wan_down
         fi
      fi
      ;;
   config_pptp_peers)
      prepare_pptp_peers
      ;;
   *)
      ulog pptp_wan status "$PID Invalid parameter $1 "
      exit 3
      ;;
esac
