    lockfile=$1
    rm -f "$lockfile"
    trap - INT TERM EXIT
