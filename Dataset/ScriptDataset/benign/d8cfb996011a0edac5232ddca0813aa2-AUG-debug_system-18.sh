	printf "#############################################vlan##########################################\n"
	objReq vlan show
	printf "===================egress vlan=====================\n"
	cat /proc/net/vlan/*
	printf "===================switch=====================\n"
	cat /proc/mt7621/esw_cnt
	printf "\n"
