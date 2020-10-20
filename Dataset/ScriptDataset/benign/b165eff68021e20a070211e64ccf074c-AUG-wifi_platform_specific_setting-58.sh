	MANUFACTURER=`syscfg get device::manufacturer`
	nvram_set wps_mfstring "$MANUFACTURER"
	MODELNUM=`syscfg get device::modelNumber`
	nvram_set wps_modelnum "$MODELNUM"
