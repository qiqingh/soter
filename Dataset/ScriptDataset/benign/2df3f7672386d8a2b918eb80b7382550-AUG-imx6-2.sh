	blkid | grep "PTUUID=\"$(rootpartuuid)\"" | cut -d : -f1
