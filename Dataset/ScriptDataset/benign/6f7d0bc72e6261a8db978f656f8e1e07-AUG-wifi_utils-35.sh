	PHY_IF=$1
	EDCCA=`syscfg_get edcca_enable`
	if [ "`syscfg get device::cert_region`" != "EU" ] ; then
		return
	fi
