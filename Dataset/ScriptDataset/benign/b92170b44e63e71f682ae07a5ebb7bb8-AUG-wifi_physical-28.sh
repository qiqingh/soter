	PHY_IF=$1
	GRNFIELDPRE=`get_driver_grn_field_pre "$PHY_IF"`
	if [ "1" = "$GRNFIELDPRE" ]; then
		echo "wifi, $PHY_IF setting greenfield"
		set_wifi_val $PHY_IF HT_OpMode $GRNFIELDPRE
	else
		set_wifi_val $PHY_IF HT_OpMode 0
	fi
	return 0
