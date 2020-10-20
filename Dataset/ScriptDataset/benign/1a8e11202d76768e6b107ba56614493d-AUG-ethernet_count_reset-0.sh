#!/bin/sh
echo [$0] ... > /dev/console

rgdb -i -s "/runtime/stats/ethernet/rx/bytes" "0"
rgdb -i -s "/runtime/stats/ethernet/rx/packets" "0"
rgdb -i -s "/runtime/stats/ethernet/rx/drop" "0"
rgdb -i -s "/runtime/stats/ethernet/tx/bytes" "0"
rgdb -i -s "/runtime/stats/ethernet/tx/packets" "0"
rgdb -i -s "/runtime/stats/ethernet/tx/drop" "0"


LAN_RX_BYTES=`rgdb -i -g /runtime/stats/ethernet/rx/bytes_c`
rgdb -i -s "/runtime/stats/ethernet/rx/bytes_reduce" "$LAN_RX_BYTES"

LAN_RX_PACKETS=`rgdb -i -g /runtime/stats/ethernet/rx/packets_c`
rgdb -i -s "/runtime/stats/ethernet/rx/packets_reduce" "$LAN_RX_PACKETS"

LAN_RX_DROP=`rgdb -i -g /runtime/stats/ethernet/rx/drop_c`
rgdb -i -s "/runtime/stats/ethernet/rx/drop_reduce" "$LAN_RX_DROP"

LAN_TX_BYTES=`rgdb -i -g /runtime/stats/ethernet/tx/bytes_c`
rgdb -i -s "/runtime/stats/ethernet/tx/bytes_reduce" "$LAN_TX_BYTES"

LAN_TX_PACKETS=`rgdb -i -g /runtime/stats/ethernet/tx/packets_c`
rgdb -i -s "/runtime/stats/ethernet/tx/packets_reduce" "$LAN_TX_PACKETS"

LAN_TX_DROP=`rgdb -i -g /runtime/stats/ethernet/tx/drop_c`
rgdb -i -s "/runtime/stats/ethernet/tx/drop_reduce" "$LAN_TX_DROP"

