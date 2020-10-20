	sed -i 's/^[ \t]*//;s/[ \t]*$//' $DATFILE
	sed -i '/^-$/d' $DATFILE
	sed -i '/^$/d' $DATFILE
	sed -i "#'##g" $DATFILE
