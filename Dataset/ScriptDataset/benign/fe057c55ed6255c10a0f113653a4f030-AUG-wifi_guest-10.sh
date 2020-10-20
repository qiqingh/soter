	mac=$1
	shf=1
	mask=`echo $((1<<$shf))`
	b1_hex=`echo $mac | cut -d: -f1`
	b1_dec=`printf "%d" 0x$b1_hex`
	new_b1_dec=$((b1_dec | 1<<$shf))
	new_b1_hex=`printf "%02X" $new_b1_dec`
	b2=`echo $mac | cut -d: -f2`
	b3=`echo $mac | cut -d: -f3`
	b4=`echo $mac | cut -d: -f4`
	b5=`echo $mac | cut -d: -f5`
	b6=`echo $mac | cut -d: -f6`
	guest_mac="$new_b1_hex:$b2:$b3:$b4:$b5:$b6"
	echo "$guest_mac"
