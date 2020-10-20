	login=`nvram_get 2860 Login`
	pass=`nvram_get 2860 Password`
	if [ "$login" != "" -a "$pass" != "" ]; then
	echo "$login::0:0:Adminstrator:/:/bin/sh" > /etc/passwd
	echo "$login:x:0:$login" > /etc/group
		chpasswd.sh $login $pass
	fi
	if [ "$CONFIG_PPPOL2TP" == "y" ]; then
	echo "l2tp 1701/tcp l2f" > /etc/services
	echo "l2tp 1701/udp l2f" >> /etc/services
	fi
