	card0_profile_path=`cat /etc/wireless/l1profile.dat | grep INDEX0_profile_path |awk -F "[=;]" '{ print $2 }'`
	#MapEnable=`cat ${card0_profile_path} | grep MapEnable | awk -F "=" '{ print $2 }'`
	#MapTurnKey=`cat ${card0_profile_path} | grep MAP_Turnkey | awk -F "=" '{ print $2 }'`
	#BSEnable=`cat ${card0_profile_path} | grep BSEnable | awk -F "=" '{ print $2 }'`
	MapMode=`cat ${card0_profile_path} | grep MapMode | awk -F "=" '{ print $2 }'`

