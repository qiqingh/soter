	local mac=$1
	local val=$2
	local oui=${mac%:*:*:*}
	local nic=${mac#*:*:*:}

	nic=$(printf "%06x" $((0x${nic//:/} + val & 0xffffff)) | sed 's/^\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3/')
	echo $oui:$nic
