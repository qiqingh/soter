	ErrorCode=2
	Debug "verify_linksys_header"
	
	LINKSYS_HDR="/tmp/linksys.hdr"
	FILE_LENGTH=`stat -c%s "$1"`
	IMAGE_LENTGH=`expr "$FILE_LENGTH" - 256`
	dd if="$1" of="$LINKSYS_HDR" skip="$IMAGE_LENTGH" bs=1 count=256 > /dev/console
	magic_string="`cat $LINKSYS_HDR | cut -b 1-9`"
	if [ "$magic_string" != ".LINKSYS." ]
	then
		ulog autofwup status  "Fail : verify magic string "
		exit $ErrorCode
	fi
	hdr_version="`cat $LINKSYS_HDR | cut -b 10-11`"
	hdr_length="`cat $LINKSYS_HDR | cut -b 12-16`"
	sku_length="`cat $LINKSYS_HDR | cut -b 17`"
	sku_end=`expr 18 + "$sku_length" - 2`
	sku_string="`cat $LINKSYS_HDR | cut -b 18-$sku_end`"
	img_cksum="`cat $LINKSYS_HDR | cut -b 33-40`"
	sign_type="`cat $LINKSYS_HDR | cut -b 41`"
	signer="`cat $LINKSYS_HDR | cut -b 42-48`"
	kernel_ofs="`cat $LINKSYS_HDR | cut -b 50-56`"
	rfs_ofs="`cat $LINKSYS_HDR | cut -b 58-64`"
	crc1=`dd if="$1" bs="$IMAGE_LENTGH" count=1| cksum | cut -d' ' -f1`
	hex_cksum=`printf "%08X" "$crc1"`
	if [ "$img_cksum" != "$hex_cksum" ]
	then
		ulog autofwup status "Fail : verify image checksum "
		Debug "Checksum Error"
		exit $ErrorCode
	fi
	
	Debug "verify_linksys_header: success"
