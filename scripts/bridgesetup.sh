#!/bin/sh
brctl addbr vmbr0
brctl stp vmbr0 off
brctl setfd vmbr0 0

ipaddr=`ifconfig ens6f0 | aws '/inet / {print $2}'`
ifconfig vmbr0 $ipaddr
brctl addif vmbr0 ens6f0

default_gw=`ip r | grep default | aws '{print $3}'`

route add default gw $default_gw vmbr0
route del default gw $default_gw ens6f0
ifconfig ens6f0 0.0.0.0
