	for PHY_IF in $PHYSICAL_IF_LIST; do
		REGION=`syscfg_get device::cert_region`
		if [ "$REGION" = "EU" ]; then
			COUNTRY_CODE="GB"
		else
			COUNTRY_CODE="US"
		fi
		ifconfig $PHY_IF up
		iwpriv $PHY_IF set CountryCode=$COUNTRY_CODE
	done
	return 0
