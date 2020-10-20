#!/bin/sh
if [ "$(nvram get openvpn_enable)" = "1" ]; then
/bin/echo -e "Serverlog: <br>"
/bin/echo -e "<br>"
/bin/cat /tmp/openvpn/openvpn.conf

/bin/echo -e "<br><br><br>"
fi
if [ "$(nvram get openvpncl_enable)" = "1" ]; then
/bin/echo -e "Clientlog: <br>"
/bin/echo -e "<br>"
/bin/cat /tmp/openvpncl/openvpn.conf
fi