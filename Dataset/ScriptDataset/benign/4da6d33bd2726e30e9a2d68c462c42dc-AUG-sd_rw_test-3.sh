	echo "#Date : `date`"
	echo "#--- R/W test Run $COUNT ---"
	if [ "$OPTION" == "rw" -o "$OPTION" == "wo" ]; then
	echo "# Memory ===> SD"
		for i in 16m 32m 64m 128m 256m 512m 1024m
		do
			echo "...Start writing filesize=$i to SD..."
			rm -rf $MOUNT/DDFile*
			sync
			lmdd if=internal of=$MOUNT/DDFile$i move=$i fsync=1
		done
	fi
	if [ ! -f $MOUNT/DDFile1024m ]; then
		echo "... Generating filesize=1024m in SD..."
		lmdd if=internal of=$MOUNT/DDFile1024m move=1024m fsync=1
	fi
	if [ "$OPTION" == "rw" -o "$OPTION" == "ro" ]; then
		echo "# SD ===> Memory"
		for i in 16m 32m 64m 128m 256m 512m 1024m
		do
			echo "...Start reading filesize=$i from SD..."
			lmdd if=$MOUNT/DDFile1024m of=internal move=$i fsync=1
		done
	fi
	rm -rf $MOUNT/DDFile*
