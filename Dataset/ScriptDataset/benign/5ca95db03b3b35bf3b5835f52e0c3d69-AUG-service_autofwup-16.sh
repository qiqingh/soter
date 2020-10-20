	ErrorCode=2
	Debug "verify_signature [$1]"
	if [ ! -e "$1" ]; then
		exit $ErrorCode
	fi
	RegionCode=`skuapi -g cert_region | awk -F"=" '{print $2}' | sed 's/ //g'`
	ProdType=$(cat /etc/product.type)
	GpgMode=$(syscfg get fwup_gpg_mode)
	extract_gpg_image "$1"
	if [ $? -ne 0 ]; then
		FirmwareImage=""
	fi
	if [ "$FirmwareImage" == "" ]; then
		if [ "$RegionCode" == "US" ] && [ "$ProdType" == "production" ]; then
			exit $ErrorCode
		elif [ "$GpgMode" == "1" ]; then
			exit $ErrorCode
		else
			FirmwareImage="$1"
		fi
	fi
