	PHY_IF=$1
	STBC=`get_driver_stbc "$PHY_IF"`
	INT=`get_phy_interface_name_from_vap "$PHY_IF"`
	iwpriv $INT rxstbc $STBC
	iwpriv $INT txstbc $STBC
	if [ "1" = "$STBC" ]; then
		iwpriv $INT TxBFCTL 0
	else
		iwpriv $INT TxBFCTL 246		
	fi
	return 0
