	echo -e "updating $1\n"
        mtd erase /dev/$2
        nandwrite -p /dev/$2 $3
