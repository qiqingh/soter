    if [ ! -d $USBINFO ] ; then
        mkdir -p $USBINFO
    fi
    local devname=$1
    local devport=$2
    local devtype=$3
    local parttype=$4
    local parttable=$5
    
    local usbfile="$USBINFO/$devname.nfo"
    touch "$usbfile"
    echo -e "pname:$devname" > "$usbfile"
    echo -e "dname:${devname::3}" >> "$usbfile"
    echo -e "type:$devtype" >> "$usbfile"
    echo -e "port:$devport" >> "$usbfile"
    echo -e "label:`/usr/sbin/usblabel $devname`" >> "$usbfile"
    echo -e "format:$parttype" >> "$usbfile"
    echo -e "partitiontable:$parttable" >> "$usbfile"
    if [ "$parttype" != "unsupported" ] && [ "$parttable" != "unsupported" ]; then
        Hotplug_GetInfo "$devname"
        echo -e "size:`df /tmp/$devname | grep $devname | awk '{print $2}'`"  >> "$usbfile"
        echo -e "manufacturer:$DEVICE_VENDOR" >> "$usbfile"
        echo -e "product:$DEVICE_MODEL" >> "$usbfile"
        echo -e "speed:$DEVICE_SPEED" >> "$usbfile"
    else
        echo -e "size:"  >> "$usbfile"
        echo -e "manufacturer:" >> "$usbfile"
        echo -e "product:" >> "$usbfile"
        echo -e "speed:" >> "$usbfile"
    fi
