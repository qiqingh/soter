        mkdir -p /tmp/root
        /bin/mount -t tmpfs -o noatime,mode=0755 root /tmp/root
        mkdir -p /tmp/root/root /tmp/root/work
        fopivot /tmp/root/root /tmp/root/work /rom 1
