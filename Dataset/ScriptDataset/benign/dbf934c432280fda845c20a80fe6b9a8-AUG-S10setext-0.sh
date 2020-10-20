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
xmldbc -x /runtime/nvram/flash					"get:devdata get -e flash"
xmldbc -x /runtime/nvram/clouduic				"get:devdata get -e clouduic"
# time
xmldbc -x /runtime/sys/uptime					"get:uptime seconly"
xmldbc -x /runtime/time/date					"get:date +%m/%d/%Y"
xmldbc -x /runtime/time/time					"get:date +%T"
xmldbc -x /runtime/time/rfc1123					"get:date +'%a, %d %b %Y %X %Z'"
xmldbc -x /runtime/time/dateddyymm  				"get:date +%d,%b,%Y"
xmldbc -x /runtime/time/week					"get:date +'%a'"
# statistics
xmldbc -x /runtime/stats/ethernet/rx/bytes_c			"get:scut -p eth0: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/ethernet/rx/packets_c			"get:scut -p eth0: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/ethernet/rx/drop_c          		"get:scut -p eth0: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/ethernet/tx/bytes_c			"get:scut -p eth0: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/ethernet/tx/packets_c			"get:scut -p eth0: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/ethernet/tx/drop_c                     "get:scut -p eth0: -f 12 /proc/net/dev"
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
rgdb -i -s "/runtime/stats/wireless/led11a" "0"
rgdb -i -s "/runtime/stats/wireless/led11g" "0"

# wireless statistic 
xmldbc -x /runtime/stats/wireless/ath:0/rx/bytes		"get:scut -p ath0: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:0/rx/packets	"get:scut -p ath0: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:0/tx/bytes		"get:scut -p ath0: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:0/tx/packets	"get:scut -p ath0: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:0/rx/drop       "get:scut -p ath0: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:0/tx/drop       "get:scut -p ath0: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:1/rx/bytes      "get:scut -p ath1: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:1/rx/packets    "get:scut -p ath1: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:1/tx/bytes      "get:scut -p ath1: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:1/tx/packets    "get:scut -p ath1: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:1/rx/drop       "get:scut -p ath1: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:1/tx/drop       "get:scut -p ath1: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:2/rx/bytes      "get:scut -p ath2: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:2/rx/packets    "get:scut -p ath2: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:2/tx/bytes      "get:scut -p ath2: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:2/tx/packets    "get:scut -p ath2: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:2/rx/drop       "get:scut -p ath2: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:2/tx/drop       "get:scut -p ath2: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:3/rx/bytes      "get:scut -p ath3: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:3/rx/packets    "get:scut -p ath3: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:3/tx/bytes      "get:scut -p ath3: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:3/tx/packets    "get:scut -p ath3: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:3/rx/drop       "get:scut -p ath3: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:3/tx/drop       "get:scut -p ath3: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:4/rx/bytes      "get:scut -p ath4: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:4/rx/packets    "get:scut -p ath4: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:4/tx/bytes      "get:scut -p ath4: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:4/tx/packets    "get:scut -p ath4: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:4/rx/drop       "get:scut -p ath4: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:4/tx/drop       "get:scut -p ath4: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:5/rx/bytes      "get:scut -p ath5: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:5/rx/packets    "get:scut -p ath5: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:5/tx/bytes      "get:scut -p ath5: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:5/tx/packets    "get:scut -p ath5: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:5/rx/drop       "get:scut -p ath5: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:5/tx/drop       "get:scut -p ath5: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:6/rx/bytes      "get:scut -p ath6: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:6/rx/packets    "get:scut -p ath6: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:6/tx/bytes      "get:scut -p ath6: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:6/tx/packets    "get:scut -p ath6: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:6/rx/drop       "get:scut -p ath6: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:6/tx/drop       "get:scut -p ath6: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:7/rx/bytes      "get:scut -p ath7: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:7/rx/packets    "get:scut -p ath7: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:7/tx/bytes      "get:scut -p ath7: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:7/tx/packets    "get:scut -p ath7: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:7/rx/drop       "get:scut -p ath7: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:7/tx/drop       "get:scut -p ath7: -f 12 /proc/net/dev"


xmldbc -x /runtime/stats/wireless/ath:8/rx/bytes      "get:scut -p ath8: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:8/rx/packets    "get:scut -p ath8: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:8/tx/bytes      "get:scut -p ath8: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:8/tx/packets    "get:scut -p ath8: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:8/rx/drop       "get:scut -p ath8: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:8/tx/drop       "get:scut -p ath8: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:9/rx/bytes      "get:scut -p ath9: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:9/rx/packets    "get:scut -p ath9: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:9/tx/bytes      "get:scut -p ath9: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:9/tx/packets    "get:scut -p ath9: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:9/rx/drop       "get:scut -p ath9: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:9/tx/drop       "get:scut -p ath9: -f 12 /proc/net/dev"


xmldbc -x /runtime/stats/wireless/ath:10/rx/bytes      "get:scut -p ath10: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:10/rx/packets    "get:scut -p ath10: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:10/tx/bytes      "get:scut -p ath10: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:10/tx/packets    "get:scut -p ath10: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:10/rx/drop       "get:scut -p ath10: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:10/tx/drop       "get:scut -p ath10: -f 12 /proc/net/dev"


xmldbc -x /runtime/stats/wireless/ath:11/rx/bytes      "get:scut -p ath11: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:11/rx/packets    "get:scut -p ath11: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:11/tx/bytes      "get:scut -p ath11: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:11/tx/packets    "get:scut -p ath11: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:11/rx/drop       "get:scut -p ath11: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:11/tx/drop       "get:scut -p ath11: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:12/rx/bytes      "get:scut -p ath12: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:12/rx/packets    "get:scut -p ath12: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:12/tx/bytes      "get:scut -p ath12: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:12/tx/packets    "get:scut -p ath12: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:12/rx/drop       "get:scut -p ath12: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:12/tx/drop       "get:scut -p ath12: -f 12 /proc/net/dev"


xmldbc -x /runtime/stats/wireless/ath:13/rx/bytes      "get:scut -p ath13: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:13/rx/packets    "get:scut -p ath13: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:13/tx/bytes      "get:scut -p ath13: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:13/tx/packets    "get:scut -p ath13: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:13/rx/drop       "get:scut -p ath13: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:13/tx/drop       "get:scut -p ath13: -f 12 /proc/net/dev"


xmldbc -x /runtime/stats/wireless/ath:14/rx/bytes      "get:scut -p ath14: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:14/rx/packets    "get:scut -p ath14: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:14/tx/bytes      "get:scut -p ath14: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:14/tx/packets    "get:scut -p ath14: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:14/rx/drop       "get:scut -p ath14: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:14/tx/drop       "get:scut -p ath14: -f 12 /proc/net/dev"

xmldbc -x /runtime/stats/wireless/ath:15/rx/bytes      "get:scut -p ath15: -f 1 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:15/rx/packets    "get:scut -p ath15: -f 2 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:15/tx/bytes      "get:scut -p ath15: -f 9 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:15/tx/packets    "get:scut -p ath15: -f 10 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:15/rx/drop       "get:scut -p ath15: -f 4 /proc/net/dev"
xmldbc -x /runtime/stats/wireless/ath:15/tx/drop       "get:scut -p ath15: -f 12 /proc/net/dev"

#ssid mac address
 
xmldbc -x /runtime/wan/inf:1/ssidmac1     "get:iwconfig ath1 |scut -p Point:|sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'"
xmldbc -x /runtime/wan/inf:1/ssidmac2     "get:iwconfig ath2 |scut -p Point:|sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'"
xmldbc -x /runtime/wan/inf:1/ssidmac3     "get:iwconfig ath3 |scut -p Point:|sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'"


# cable status
xmldbc -x /runtime/switch/port:1/nktype		"get:psts -i 3"
xmldbc -x /runtime/switch/port:2/linktype		"get:psts -i 2"
xmldbc -x /runtime/switch/port:3/linktype		"get:psts -i 1"
xmldbc -x /runtime/switch/port:4/linktype		"get:psts -i 0"
xmldbc -x /runtime/switch/wan_port				"get:psts -i 4"
