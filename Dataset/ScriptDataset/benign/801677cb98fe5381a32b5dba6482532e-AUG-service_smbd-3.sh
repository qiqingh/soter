	if [ -d "/mnt" ] ; then
		drive=`ls /mnt/ | grep sd | sort`
		if [ "$drive" ] ; then
			echo "$drive"
		fi
  fi
