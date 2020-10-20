    mf_feedback "Flushing SIP subscriber database in NVRAM..."
    nvram set milkfish_subscriber= && echo "Done."
    mf_feedback "Flushing SIP aliases database in NVRAM..."
    nvram set milkfish_aliases= && echo "Done."
