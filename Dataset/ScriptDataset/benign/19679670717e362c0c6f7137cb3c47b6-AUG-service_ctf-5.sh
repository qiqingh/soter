    if [ -f $CTF_BYPASS_SWITCH ]; then
        CTF_BYPASS_SUPPORTED=1
        CTF_ENABLE_FUNC=set_ctf_enable
        CTF_DISABLE_FUNC=set_ctf_disable
        if [ -f $CTF_SWITCH ]; then
            set_ctf_on
        fi
    else
        CTF_BYPASS_SUPPORTED=0
        CTF_ENABLE_FUNC=set_ctf_on
        CTF_DISABLE_FUNC=set_ctf_off
    fi
