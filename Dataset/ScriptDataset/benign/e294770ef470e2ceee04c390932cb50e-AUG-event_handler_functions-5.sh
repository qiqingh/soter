    local LOCK_FILE=$1
    if (set -o noclobber; echo "$$" > "$LOCK_FILE") 2> /dev/null
    then  # Try to lock a file
        trap 'rm -f "$LOCK_FILE"; exit $?' INT TERM EXIT;
        return 0;
    fi
    return 1
