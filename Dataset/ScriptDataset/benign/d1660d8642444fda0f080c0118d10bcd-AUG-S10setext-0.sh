#!/bin/sh
echo [$0] ... > /dev/console

# NVRAM, rgcfg.
xmldbc -x /runtime/nvram/flashspeed				"get:devdata get -e flashspeed"
xmldbc -x /runtime/nvram/pin					"get:devdata get -e pin"
xmldbc -x /runtime/nvram/wanmac					"get:devdata get -e wanmac"
xmldbc -x /runtime/nvram/lanmac					"get:devdata get -e lanmac"
xmldbc -x /runtime/nvram/wlanmac				"get:devdata get -e wlanmac"
xmldbc -x /runtime/nvram/hwrev					"get:devdata get -e hwrev"
xmldbc -x /runtime/nvram/countrycode			"get:devdata get -e countrycode"
# time
xmldbc -x /runtime/sys/uptime					"get:uptime seconly"
xmldbc -x /runtime/time/date					"get:date +%m/%d/%Y"
xmldbc -x /runtime/time/time					"get:date +%T"
xmldbc -x /runtime/time/rfc1123					"get:date +'%a, %d %b %Y %X %Z'"
# statistics
xmldbc -x /runtime/stats/ethernet/rx/bytes_c         "get:scut -p rx_bytes: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/rx/packets_c       "get:scut -p rx_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/rx/drop_c          "get:scut -p rx_dropped: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/tx/bytes_c         "get:scut -p tx_bytes: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/tx/packets_c       "get:scut -p tx_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/tx/drop_c          "get:scut -p tx_dropped: -f 1 /proc/octeon_alpha_ethernet_stats"
#Free Memory
xmldbc -x /runtime/stats/memfree "get:scut -p MemFree: -f 1 /proc/meminfo"

rgdb -i -s "/runtime/stats/ethernet/rx/bytes_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/rx/bytes"	"0"
rgdb -i -s "/runtime/stats/ethernet/rx/packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/rx/packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/rx/drop_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/rx/drop"	"0"

rgdb -i -s "/runtime/stats/ethernet/tx/bytes_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/tx/bytes"	"0"
rgdb -i -s "/runtime/stats/ethernet/tx/packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/tx/packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/tx/drop_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/tx/drop"	"0"




# octeon ethernet statistics 
xmldbc -x /runtime/stats/ethernet/count/len_64_packets_c		"get:scut -p len_64_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/len_65_127_packets_c		"get:scut -p len_65_127_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/len_128_255_packets_c	"get:scut -p len_128_255_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/len_256_511_packets_c	"get:scut -p len_256_511_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/len_512_1023_packets_c	"get:scut -p len_512_1023_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/len_1024_1518_packets_c	"get:scut -p len_1024_1518_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/len_1519_max_packets_c	"get:scut -p len_1519_max_packets: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/multicast_c			"get:scut -p multicast: -f 1 /proc/octeon_alpha_ethernet_stats"
xmldbc -x /runtime/stats/ethernet/count/broadcast_packets_c		"get:scut -p broadcast_packets: -f 1 /proc/octeon_alpha_ethernet_stats"

rgdb -i -s "/runtime/stats/ethernet/count/len_64_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_64_packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_65_127_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_65_127_packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_128_255_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_128_255_packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_256_511_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_256_511_packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_512_1023_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_512_1023_packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_1024_1518_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_1024_1518_packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_1519_max_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/len_1519_max_packets"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/multicast_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/multicast"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/broadcast_packets_reduce"	"0"
rgdb -i -s "/runtime/stats/ethernet/count/broadcast_packets"	"0"

xmldbc -x /runtime/stats/wireless/rx/bytes		"get:scut -p wifi0: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/rx/packets	"get:scut -p wifi0: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/tx/packets	"get:scut -p wifi0: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/tx/bytes		"get:scut -p wifi0: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/rx/drop       "get:scut -p wifi0: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/tx/drop       "get:scut -p wifi0: -f 12 /proc/net/dev"

# cable status
xmldbc -x /runtime/switch/port:1/linktype		"get:psts -i 3"
xmldbc -x /runtime/switch/port:2/linktype		"get:psts -i 2"
xmldbc -x /runtime/switch/port:3/linktype		"get:psts -i 1"
xmldbc -x /runtime/switch/port:4/linktype		"get:psts -i 0"
xmldbc -x /runtime/switch/wan_port				"get:psts -i 4"
