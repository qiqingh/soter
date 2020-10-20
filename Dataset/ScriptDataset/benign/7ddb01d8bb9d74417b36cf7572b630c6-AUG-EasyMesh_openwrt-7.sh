		DeviceRole=`cat /etc/map/mapd_cfg | grep DeviceRole | awk -F "=" '{ print $2 }'`
		sed -i "s/lan=.*/lan=${lan_iface}/g" /etc/map/1905d.cfg
		sed -i "s/wan=.*/wan=${wan_iface}/g" /etc/map/1905d.cfg
		sed -i "s/radio_band=.*/radio_band=${radio_band}/g" /etc/map/1905d.cfg
		sed -i "s/map_controller_alid=.*/map_controller_alid=${ctrlr_al_mac}/g" /etc/map/1905d.cfg
		sed -i "s/map_agent_alid=.*/map_agent_alid=${agent_al_mac}/g" /etc/map/1905d.cfg
		sed -i "s/bss_config_priority=.*/bss_config_priority=${if_list}/g" /etc/map/1905d.cfg
		if [ $DeviceRole = "1" ]
		then
			sed -i "s/map_agent=.*/map_agent=0/g" /etc/map/1905d.cfg
			sed -i "s/map_root=.*/map_root=1/g" /etc/map/1905d.cfg
		else
			sed -i "s/map_agent=.*/map_agent=1/g" /etc/map/1905d.cfg
			sed -i "s/map_root=.*/map_root=0/g" /etc/map/1905d.cfg
		fi
