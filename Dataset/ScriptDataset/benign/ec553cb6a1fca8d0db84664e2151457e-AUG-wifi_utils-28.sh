	echo "setting 2.4GHz AH certification settings"
	wl -i eth2 txcore -k 0x1
	wl -i eth2 txpwr1 -o -d 15 -b b
