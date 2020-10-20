	Error=2
	check_gpg_signature "$1"
	
	if [ $? -ne 0 ]; then
		return $Error		
	fi
	decrypt_gpg_image "$1"
	if [ $? -ne 0 ]; then
		return $Error		
	fi
