        /bin/mount -o noatime,move /proc $1/proc && \
        pivot_root $1 $1$2 && {
                /bin/mount -o noatime,move $2/dev /dev
                /bin/mount -o noatime,move $2/tmp /tmp
                /bin/mount -o noatime,move $2/sys /sys 2>&-
                /bin/mount -o noatime,move $2/overlay /overlay 2>&-
                return 0
        }   
