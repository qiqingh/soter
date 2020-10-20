    log "Verify firmware header..."

    GEMTEK_HDR="/tmp/gemtek.hdr"
    FILE_PATH=$(cat /tmp/fwpath)
    FILE_LENGTH=$(stat -c%s $FILE_PATH)
    FW_LENGTH=$(expr $FILE_LENGTH - 16)
    dd if="$FILE_PATH" of="$GEMTEK_HDR" skip="$FW_LENGTH" bs=1 count=256 > /dev/console

    CHECKFW='1'
    HDR_MAGIC_STRING="$(cat $GEMTEK_HDR | cut -b 1-8)"
    if [ "$HDR_MAGIC_STRING" != ".GEMTEK." ]; then
        log "Wrong magic string."
        CHECKFW='0'
    fi

    HDR_FW_CRC="$(cat $GEMTEK_HDR | cut -b 9-16)"
    FW_CRC=$(dd if="$FILE_PATH" bs="$FW_LENGTH" count=1 | cksum | cut -d' ' -f1)
    FW_HEX_CRC=$(printf "%08X" $FW_CRC)
    if [ "$HDR_FW_CRC" != "$FW_HEX_CRC" ]; then
        log "firmware checksum error."
        CHECKFW='0'
    fi

    log "Check firmware Done and status [$CHECKFW]"
