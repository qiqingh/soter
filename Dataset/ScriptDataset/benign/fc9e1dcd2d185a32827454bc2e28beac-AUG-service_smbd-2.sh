	if [ -d "/mnt" ] ; then
		drive=`ls /mnt/ | grep sd | sort | head -n 1`
		if [ "$drive" ] ; then
			echo "$drive"
		fi
  fi
