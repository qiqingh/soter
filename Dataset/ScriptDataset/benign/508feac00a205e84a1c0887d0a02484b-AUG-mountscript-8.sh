    local blockdir
    local blockname
    blockdir="/sys/block/$1"
    if [ -d "$blockdir" ]; then
        blockname=`ls -la $blockdir`
        echo "$blockname" | grep -q "/devices/platform/sata_mv.0"
        if [ "$?" = "0" ]; then
            UMOUNT="esata"
            return
        fi
        echo "$blockname" | grep -q "/devices/platform/ehci_marvell.0/usb"
        if [ "$?" = "0" ]; then
            UMOUNT="usb1"
            return
        fi
        echo "$blockname" | grep -q "/devices/pci0000:00/0000:00:00.0/usb"
        if [ "$?" = "0" ]; then
            UMOUNT="usb2"
            return
        fi
    fi
