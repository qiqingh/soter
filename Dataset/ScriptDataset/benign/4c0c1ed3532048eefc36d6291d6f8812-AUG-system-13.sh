	local mac=$1
	local bit=${2:-0}

	[ $bit -gt 0 -a $bit -le 48 ] || return

	printf "%012x" $(( 0x${mac//:/} | 2**(48-bit) )) | sed -e 's/\(.\{2\}\)/\1:/g' -e 's/:$//'
