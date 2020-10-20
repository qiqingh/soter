    DEVICE_VENDOR=
    DEVICE_MODEL=
    DEVICE_SPEED=
    local devname=$1
    Hotplug_GetDevpath "$devname"
    Hotplug_GetInfoFromDevpath "$DEVICE_PATH"
