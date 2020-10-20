	Error=2
	Debug "decrypt_gpg_image"
	ImageFile="$GNUPGHOME/firmware"
	gpg --ignore-time-conflict -d "$1" > $ImageFile
	
	if [ $? -ne 0 ]; then
		return $Error
	fi
	FirmwareImage="$ImageFile"
	Debug "decrypt_gpg_image: success"
