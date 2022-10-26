#!/bin/bash

# monitoring.sh

# By: dmatavel <dmatavel@student.42.rio>

# This script displays a message with important system information to all terminals of a Debian-based server.
# It was created as a part of the "born2beroot" project of the 42 School.
# Check the notes at the end of this file for additional information about how this script works.

# Operating system's architecture and kernel version:
HW=`uname -a`

# Number of processors.
CPU=`grep -c process /proc/cpuinfo`

# Current available RAM on your server and its utilization rate as a percentage. 
MEM_USG=`free -m | grep "Mem" | awk '{print $3"/"$2"MB"}'`
MEM_USG_PRCNT=`free -m | grep "Mem" | awk '{printf("(%.2f%%)\n", $3 * 100 / $2)}' | sed s/,/./`

# Current available memory on your server and its utilization rate as a percentage.
DSK_USG=`df -BM -P --total | grep "total" | awk '{print $3"/"}' | sed s/M/\/`
DSK_SIZE=`df -BG -P --total | grep "total" | awk '{print $2"Gb"}' | sed s/G/\/`
DSK_USG_PRCNT=`df -BG -P --total | grep "total" | awk '{ printf("(%.1f%%)\n", $3 / $2 * 100.0) }' | sed s/,/./`

# Current utilization rate of your processors as a percentage.
CPU_USG=`iostat -ch --pretty | sed -n '4p' | awk '{ printf("%.1f%%\n", 100.0 - $6) }' | sed s/,/./`

# Date and time of the last boot.
LST_BOOT_DT=`who -b | awk '{ print $4}'`
LST_BOOT_HR=`who -b | awk '{ print $5}'`

# Wether LVM is active or not.
LVM_CHECK=`lsblk | grep -o "lvm" | awk 'NF==1 { if ($1 == "lvm") { print "yes"; exit; } else { print "no"; exit; } }'`

# Active TCP connections:
TCP_CON=`ss | grep -c "tcp"`

# Users using the server.
USR_CNT=`who | cut -d " " -f 1 | sort -u | wc -l`

# IPv4 address.
IP_ADRS=`hostname -I`

# MAC (Media Access Control) address:
MAC_ADRS=`ip -o link show | sed -n '2p' | awk '{ print $17 }'`

# Number of commands executed with the sudo program:
SUDO_CNT=`grep -c "sudo " /var/log/auth.log`

# Send a message to all terminals of the server:

wall "#Architecture: ${HW}
#CPU physical : ${CPU}
#vCPU : ${CPU}
#Memory Usage: ${MEM_USG} ${MEM_USG_PRCNT}
#Disk Usage: ${DSK_USG}${DSK_SIZE} ${DSK_USG_PRCNT}
#CPU load: ${CPU_USG}
#Last boot: ${LST_BOOT_DT} ${LST_BOOT_HR}
#LVM use: ${LVM_CHECK}
#Connections TCP : ${TCP_CON} ESTABLISHED
#User log: ${USR_CNT}
#Network: ${IP_ADRS} IP (${MAC_ADRS})
#Sudo : ${SUDO_CNT} cmd"

# Notes:

# 1) You need to install the sysstat package in order to use the 'iostat' command.
# 2) You need to configure your sudoers file via 'sudo visudo' in order to get 
# the number of commands executed with the sudo program;
# to do that, follow the steps below:
# 2.1) 'sudo mkdir /var/log/sudo/sudo.log'
# 2.2) Open your sudoers file with 'sudo visudo':
# 2.3) Add the following lines to the file:
# Defaults  logfile="/var/log/sudo/sudo.log"
# Defaults  log_input
# Defaults  log_output
# Defaults  iolog_dir="/var/log/sudo"
