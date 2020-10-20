	PHY_IF=$1
	rate=`wl -i $PHY_IF nrate`
	case $rate in
	*auto*) 
		rate="auto";;
	*fixed*)
		rate=`echo $rate | grep -rin "mcs" | awk -F" " '{print $3}'`;;
	*)
		ERROR="incorrect mode for rate: %rate"
		echo $ERROR > /dev/console
		rate="auto";;
	esac   
    
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	sysevent set "$WL_SYSCFG"_n_transmission_rate $rate
