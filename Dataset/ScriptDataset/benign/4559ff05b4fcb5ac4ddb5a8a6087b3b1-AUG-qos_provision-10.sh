   DEV=$1
   remove_lan_qos $DEV
   tc qdisc add dev $DEV root handle 1: prio bands 8 priomap 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6
   tc qdisc add dev $DEV parent 1:1 handle 11: pfifo limit 10
   tc qdisc add dev $DEV parent 1:2 handle 12: pfifo limit 10
   tc qdisc add dev $DEV parent 1:3 handle 13: pfifo limit 20
   tc qdisc add dev $DEV parent 1:4 handle 14: pfifo limit 20
   tc qdisc add dev $DEV parent 1:5 handle 15: pfifo limit 20
   tc qdisc add dev $DEV parent 1:6 handle 16: pfifo limit 20
   tc qdisc add dev $DEV parent 1:7 handle 17: pfifo limit 15
   tc qdisc add dev $DEV parent 1:8 handle 18: pfifo limit 5
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00100000 0x00ff0000 at 0 flowid 1:2
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00b80000 0x00ff0000 at 0 flowid 1:3
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00280000 0x00ff0000 at 0 flowid 1:3
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00480000 0x00ff0000 at 0 flowid 1:4
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00680000 0x00ff0000 at 0 flowid 1:4
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00300000 0x00ff0000 at 0 flowid 1:4
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00500000 0x00ff0000 at 0 flowid 1:4
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00700000 0x00ff0000 at 0 flowid 1:4
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00380000 0x00ff0000 at 0 flowid 1:5
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00580000 0x00ff0000 at 0 flowid 1:5
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00780000 0x00ff0000 at 0 flowid 1:5
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00080000 0x00ff0000 at 0 flowid 1:6
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00040000 0x00ff0000 at 0 flowid 1:7
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32 match u32 0x00020000 0x00ff0000 at 0 flowid 1:8
   tc filter add dev $DEV parent 1:0 prio 1 protocol ip u32  match ip protocol 6 0xff  match u8 0x05 0x0f at 0  match u16 0x0000 0xffc0 at 2  match u8 0x10 0xff at 33  flowid 1:2
