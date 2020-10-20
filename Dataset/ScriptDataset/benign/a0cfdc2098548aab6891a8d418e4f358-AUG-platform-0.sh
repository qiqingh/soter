RAMFS_COPY_BIN='osafeloader oseama otrx'

PART_NAME=firmware

LXL_FLAGS_VENDOR_LUXUL=0x00000001

# $(1): file to read magic from
# $(2): offset in bytes
# $(1): file to read LE long number from
# $(2): offset in bytes
# $(1): image for upgrade (with possible extra header)
# $(2): offset of trx in image
