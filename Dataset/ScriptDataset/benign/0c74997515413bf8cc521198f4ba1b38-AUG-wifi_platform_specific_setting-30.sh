	if [ "`syscfg get device::modelNumber`" = "EA6500" ] && [ "`syscfg get device::hw_revision`" = "1" ] ; then
		ccode=`syscfg get device::ccode`
		regrev=`syscfg get device::regrev`
		if [ -z "$ccode" ] || [ -z "$regrev" ] ; then
			regioncode="Q2/13"	#default to US
		else
			regioncode="$ccode/$regrev"
		fi
		for PHY_IF in $PHYSICAL_IF_LIST; do
			wl -i $PHY_IF country $regioncode
			echo "wifi, carrera $PHY_IF country code set $regioncode" #for debugging
		done
	fi
