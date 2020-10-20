	VALID="0"
	for PHY_IF in $PHYSICAL_IF_LIST; do
		if [ "$PHY_IF" = "$1" ]; then
			VALID="1"
			break;
		fi
	done
	echo "$VALID"
