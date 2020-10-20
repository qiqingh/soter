	if [ ! -f "/etc/mapd_strng.conf" -o "$check_default" = "default" ];then
		echo "Make mapd_strng.conf"
echo "LowRSSIAPSteerEdge_RE=40
CUOverloadTh_2G=70
CUOverloadTh_5G_L=80
CUOverloadTh_5G_H=80
" > /etc/mapd_strng.conf
	fi
