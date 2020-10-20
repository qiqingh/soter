        TIME_OUT=$(GetTimer)
        if [ 0 != $TIME_OUT ]; then
                SetTimer $1
        else
                SetTimer $1
                WaitTillTimeout $1
        fi
