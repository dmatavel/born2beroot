#!/bin/bash

# variables

HW=`uname -a`
CPU=`grep process /proc/cpuinfo | wc -l`
MEM_USG=`free -m | grep Mem | awk '{print $3}'`
MEM_SIZE=`free -m | grep Mem | awk '{print $2}'`
MEM_USG_PRCNT=`free -m | grep Mem | awk '{ printf("%.2f%%\n", ($3 x 1/100 x $2) / 100) }' | sed s/,/./g`
DSK_USG=`df -BM -P --total | grep total | awk '{print $3}' | sed s/M/\/`
DSK_SIZE=`df -BG -P --total | grep total | awk '{print $2}' | sed s/M/\/`
DSK_USG_PRCNT=`df -BG -P --total | grep total | awk '{ printf("%.1f%%\n", $3/$2 * 100.0) }' | sed s/,/./g`
CPU_USG=`iostat -ch --pretty | sed -n '4p' | awk '{ printf("%.1f%%\n", 100.0 - $6) }' | sed s/,/./`
LST_BOOT_DT=`who -b | awk '{ print $4}'`
LST_BOOT_HR=`who -b | awk '{ print $5}'`
LVM_CHECK=`lsblk | grep lvm | awk '{if ($1) { print "yes"; exit;} else {print "no"}}'`
TCP_CON=`netstat | grep tcp | wc -l`
USR_CNT=`who -q | grep -o '[0-9]*'`
IP_ADRS=`hostname -I`
MAC_ADRS=`ip -o link show | sed -n '2p' | awk '{ print $17 }'`
SUDO_CNT=`cat /var/log/sudo/sudo.log | wc -l | awk '{print ($f1/2)}'`

wall "#Architecture: ${HW}
#CPU physical : ${CPU}
#vCPU : ${CPU}
#Memory Usage: ${MEM_USG}/${MEM_SIZE}MB (${MEM_USG_PRCNT})
#Disk Usage: ${DSK_USG}/${DSK_SIZE}b (${DSK_USG_PRCNT})
#CPU load: ${CPU_USG}
#Last boot: ${LST_BOOT_DT} ${LST_BOOT_HR}
#LVM use: ${LVM_CHECK}
#Connections TCP : ${TCP_CON} ESTABLISHED
#User log: ${USR_CNT}
#Network: ${IP_ADRS} IP (${MAC_ADRS})
#Sudo : ${SUDO_CNT} cmd"
