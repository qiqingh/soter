	PHY_IF=$1
	EMF_WMF=`syscfg get emf_wmf`
	if [ "disable" != "$EMF_WMF" ]; then
		wl -i $PHY_IF wmf_bss_enable 1
	else
		wl -i $PHY_IF wmf_bss_enable 0
	fi
