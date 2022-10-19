#!/bin/bash

# variables

HW=`uname -a`
CPU=`grep process /proc/cpuinfo | wc -l`
MEM_USG=`free -m | grep Mem | awk '{print $3}'`
MEM_SIZE=`free -m | grep Mem | awk '{print $2}'`
MEM_USG_PRCNT=`free -m | grep Mem | awk '{ printf("%.1f%%\n", $4/$2 * 100.0) }' | sed s/,/./g`
DSK_USG=`df -BM -P --total | grep total | awk '{print $3}' | sed s/M/\/`
DSK_SIZE=`df -BG -P --total | grep total | awk '{print $2}' | sed s/M/\/`
DSK_USG_PRCNT=`df -BG -P --total | grep total | awk '{ printf("%.1f%%\n", $3/$2 * 100.0) }' | sed s/,/./g`

wall "#Architeture: ${HW}
#CPU physical : ${CPU}
#vCPU : ${CPU}
#Memory Usage: ${MEM_USG}/${MEM_SIZE}MB (${MEM_USG_PRCNT})
#Disk Usage: ${DSK_USG}/${DSK_SIZE}b (${DSK_USG_PRCNT})"
