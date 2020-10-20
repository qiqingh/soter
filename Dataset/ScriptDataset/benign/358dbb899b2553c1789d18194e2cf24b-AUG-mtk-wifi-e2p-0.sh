#!/bin/sh

[ -f "/etc/wireless/l1profile.dat" ] || exit 0
[ -d "/lib/firmware" ] || mkdir /lib/firmware
# first line "Default" is illegal in shell
cat /etc/wireless/l1profile.dat | tail -n +2 |grep -v ";"> /tmp/l1profile.sh

. /tmp/l1profile.sh

[ "$FIRMWARE" != "" ] || FIRMWARE=$INDEX0_EEPROM_name
FW="/lib/firmware/$FIRMWARE"
[ -e "$FW" ] && exit 0

# This is the ideal way, but driver does not follow...
# case "$FIRMWARE" in
# $INDEX0_EEPROM_name)
# 	mtk_wifi_e2p_extract "Factory" `printf "%d" $INDEX0_EEPROM_offset` `printf "%d" $INDEX0_EEPROM_size`
# 	;;
# $INDEX1_EEPROM_name)
# 	mtk_wifi_e2p_extract "Factory" `printf "%d" $INDEX1_EEPROM_offset` `printf "%d" $INDEX1_EEPROM_size`
# 	;;
# $INDEX2_EEPROM_name)
# 	mtk_wifi_e2p_extract "Factory" `printf "%d" $INDEX2_EEPROM_offset` `printf "%d" $INDEX2_EEPROM_size`
# 	;;
# esac

# Then here's the compromised way

case "$FIRMWARE" in
$INDEX2_EEPROM_name)
	l1_e2p_offset=`printf "%d" $INDEX2_EEPROM_offset`
	l1_e2p_size=`printf "%d" $INDEX2_EEPROM_size`
	final_size=`expr $l1_e2p_offset + $l1_e2p_size`
	mtk_wifi_e2p_extract "Factory" 0 $final_size
	;;
$INDEX1_EEPROM_name)
	l1_e2p_offset=`printf "%d" $INDEX1_EEPROM_offset`
	l1_e2p_size=`printf "%d" $INDEX1_EEPROM_size`
	final_size=`expr $l1_e2p_offset + $l1_e2p_size`
	mtk_wifi_e2p_extract "Factory" 0 $final_size
	;;
$INDEX0_EEPROM_name)
	l1_e2p_offset=`printf "%d" $INDEX0_EEPROM_offset`
	l1_e2p_size=`printf "%d" $INDEX0_EEPROM_size`
	final_size=`expr $l1_e2p_offset + $l1_e2p_size`
	mtk_wifi_e2p_extract "Factory" 0 $final_size
	;;
esac

rm -f /tmp/l1profile.sh

