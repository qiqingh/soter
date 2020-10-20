	echo "#Date : `date`"
	echo "#--- The Loopback test Run $COUNT ---"
	rm -rf $MOUNT/backup
	sync
	mkdir $MOUNT/backup
	echo "cp $TestFile $MOUNT/backup"
#	time cp $TestFile $MOUNT/backup
	cp $TestFile $MOUNT/backup
	sync
	bk_file=`ls $MOUNT/backup`
#	ls -l $TestFile
#	ls -l $MOUNT/backup/$bk_file
	bk_file_crc=`md5sum $MOUNT/backup/$bk_file | sed 's/\/mnt\/.*//'`
	if [ "$bk_file_crc" != "$TestFileCRC" ]; then
		FAIL=`expr $FAIL + 1`
	else
		PASS=`expr $PASS + 1`
	fi
	rm -rf $MOUNT/backup
	sync
	echo "`date` --- Loopback Test: Pass-$PASS ,Failed-$FAIL ---"
