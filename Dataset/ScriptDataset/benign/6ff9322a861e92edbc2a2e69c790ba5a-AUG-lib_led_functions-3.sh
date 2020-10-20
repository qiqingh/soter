        TIME_OUT=$(GetTimer)
        if [ $TIME_OUT -lt 1 ]; then
                TIME_OUT=1;
        fi
        TIME_OUT=$(expr $TIME_OUT - 1)
        SetTimer $TIME_OUT
