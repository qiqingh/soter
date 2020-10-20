	card_gsw_setting=`cat /proc/device-tree/gsw@0/compatible`
	echo $card_gsw_setting
	if [ "$card_gsw_setting" = "mediatek,mt753x" ] ;then
		echo "found green card with MT7631 switch"
		switch reg w 34 8160816
		switch reg w 4 60
		switch reg w 10 ffffffff
	fi
	#card_gsw_setting=`cat /proc/device-tree/rtkgswsys@1b100000/compatible`
	#echo $card_gsw_setting
	#if [ "$card_gsw_setting" = "mediatek,rtk-gsw" ] ;then
	#	echo "found red card with switch RTL8367S"
	#fi
