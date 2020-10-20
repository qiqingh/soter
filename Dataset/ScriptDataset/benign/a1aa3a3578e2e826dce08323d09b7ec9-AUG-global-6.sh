        dirs=$(find /lib/modules -name 'netfilter' -type d)
        for dire in $dirs
        do
           #echo "in $dire:"
           for file in $dire/*
           do
                insmod -q  ${file%.*}
           done
        done
