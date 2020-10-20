    lockfile=$1
    lockwait=${2:-5}
    for i in `seq 1 "$lockwait"`; do
        if (set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null; then
            trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT;
            return 0;
        fi
        sleep 1
    done
    return 1
