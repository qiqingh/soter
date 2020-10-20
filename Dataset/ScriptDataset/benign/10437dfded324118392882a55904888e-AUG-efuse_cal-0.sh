iwpriv ra0 show cal
cal=`cat /tmp/efuse_cal`
val="84${cal}"
iwpriv ra0 e2p 9a8=${val}
ated -i ra0 -c "sync eeprom all"
