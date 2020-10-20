	rm -rf $CACHE_DIR
	local ifs="ra0 ra1 rai0 rai1"
	for i in ${ifs}; do
		mkdir -p $CACHE_DIR/$i
	done
