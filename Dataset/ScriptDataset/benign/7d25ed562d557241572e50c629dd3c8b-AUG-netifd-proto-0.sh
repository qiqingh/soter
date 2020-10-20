NETIFD_MAIN_DIR="${NETIFD_MAIN_DIR:-/lib/netifd}"
PROTO_DEFAULT_OPTIONS="defaultroute peerdns metric"

. /usr/share/libubox/jshn.sh
. $NETIFD_MAIN_DIR/utils.sh

