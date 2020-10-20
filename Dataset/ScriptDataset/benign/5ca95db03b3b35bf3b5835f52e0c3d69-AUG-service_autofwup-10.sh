	header_file="/tmp/img_hdr"
	magic="`cat $header_file | cut -b 1-6`"
	version="`cat $header_file | cut -b 7-8`"
	img_cksum="`cat $header_file | cut -b 25-32`"
	rm -rf $header_file
	if [ "$magic" != ".CSIH." ]
	then
		ulog autofwup status "Fail : verify magic "
		exit 1
	fi
	
	if [ "$version" != "01" ]
	then
		ulog autofwup status "Fail : verify version "
		exit 1
	fi
	crc1=`cksum $1 | cut -d' ' -f1`
	hex_cksum=`printf "%08X" "$crc1"`
	if [ "$img_cksum" != "$hex_cksum" ]
	then
		ulog autofwup status "Fail : verify checksum "
		exit 1
	fi
