	PHY_IF=$1
	REGION=`syscfg_get device::cert_region`
	case "$REGION" in
		"EU")
			REGION_CODE="6002"
			;;
		"AU")
			REGION_CODE="6004"
			;;
		"CA")
			REGION_CODE="6001"
			;;
		"AP")
			REGION_CODE="6005"
			;;
		*)
			REGION_CODE="6000"
			;;
	esac
	INT=`get_phy_interface_name_from_vap "$PHY_IF"`
	iwpriv $INT setCountryID $REGION_CODE
	return 0
