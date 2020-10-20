#!/bin/sh
nvram set wk_mode="ospf bgp rip router"
nvram set zebra_copt=1
nvram set ospfd_copt=1
nvram set ripd_copt=1
nvram set bgpd_copt=1
nvram commit
stopservice zebra
startservice zebra
