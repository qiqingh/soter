	[ $1 = "nand" ] && {
		[ -f "$2" ] && {
			touch /tmp/sysupgrade

			killall -9 telnetd
			killall -9 dropbear
			killall -9 ash

			kill_remaining TERM
			sleep 3
			kill_remaining KILL

			sleep 1

			if [ -n "$(rootfs_type)" ]; then
				v "Switching to ramdisk..."
				run_ramfs ". /lib/functions.sh; include /lib/upgrade; nand_do_upgrade_stage2 $2"
			else
				nand_do_upgrade_stage2 $2
			fi
			return 0
		}
		echo "Nand upgrade failed"
		exit 1
	}
