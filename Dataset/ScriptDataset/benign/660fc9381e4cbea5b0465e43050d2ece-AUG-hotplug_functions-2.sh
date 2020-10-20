    DEVICE_TYPE="usb"
    DEVICE_PORT=
    local devname=$1
    Hotplug_GetDevpath "$devname"
    Hotplug_GetIdFromDevpath "$DEVICE_PATH"
