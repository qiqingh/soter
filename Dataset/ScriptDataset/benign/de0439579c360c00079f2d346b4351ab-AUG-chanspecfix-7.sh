    nvram set wl_chanspec=0
    nvram set wl_radio=1
    nvram set wl0_radio=1
    nvram set wl1_radio=1
    nvram unset acs_ifnames
    nvram commit
    killall -q acsd
