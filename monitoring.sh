#!/bin/bash

# variables

HW=`uname -a`
CPU=`grep process /proc/cpuinfo | wc -l`
MEM_USED=`free -m | grep Mem | awk '{print $3}'`
MEM_TOTAL=`free -m | grep Mem | awk '{print $2}'`
MEM_FREE_PERCENT=`free -m | grep Mem | awk '{ printf("%.1f%%\n", $4/$2 * 100.0) }' | sed s/,/./g`

wall "#Architeture: ${HW}
#CPU physical : ${CPU} 
#vCPU : ${CPU} 
#Memory usage: ${MEM_USED}/${MEM_TOTAL}MB (${MEM_FREE_PERCENT})"
