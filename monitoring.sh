#!/bin/bash

# monitoring.sh

# Created by: dmatavel
# Mail: dmatavel@student.42.rio

# This script displays a message with important system informations to all terminals of a debian based server.

# Set up variables and colletc informations:

# Display the architecture of the operating system and its kernel version:

HW=`uname -a`

# Count the number of processors in the machine:

CPU=`grep -c process /proc/cpuinfo`

# Collect the amount of RAM in use:

MEM_USG=`free -m | grep Mem | awk '{print $3}'`

# Collect the total RAM:

MEM_SIZE=`free -m | grep Mem | awk '{print $2}'`

# Show the amount of RAM in use as a percentage:

MEM_USG_PRCNT=`free -m | grep Mem | awk '{ printf("%.2f%%\n", $3 * 100 / $2) }' | sed s/,/./g`

# Collect the ammount of the disk memory in use:

DSK_USG=`df -BM -P --total | grep total | awk '{print $3}' | sed s/M/\/`

# Collect the total disk size:

DSK_SIZE=`df -BG -P --total | grep total | awk '{print $2}' | sed s/M/\/`

# Display the current disk memory in use as a percentage:

DSK_USG_PRCNT=`df -BG -P --total | grep total | awk '{ printf("%.1f%%\n", $3/$2 * 100.0) }' | sed s/,/./g`

# Display the amount of CPU in use as a percentage:

CPU_USG=`iostat -ch --pretty | sed -n '4p' | awk '{ printf("%.1f%%\n", 100.0 - $6) }' | sed s/,/./`

# Display the last date and hour of the last machine's boot:

LST_BOOT_DT=`who -b | awk '{ print $4}'`
LST_BOOT_HR=`who -b | awk '{ print $5}'`

# Check if there is any logical partition in your disk:

LVM_CHECK=`lsblk | grep -o "lvm" | awk 'NF==1 { if ($1 == "lvm") { print "yes"; exit; } else { print "no"; exit; } }'`

# Count the number of active TCP connections:

TCP_CON=`netstat | grep -c tcp`

# Collect the number of users current logged on the server:

USR_CNT=`who -q | grep -o '[0-9]*'`

# Display the machine's IP address:

IP_ADRS=`hostname -I`

# Collect and display machine's MAC address:

MAC_ADRS=`ip -o link show | sed -n '2p' | awk '{ print $17 }'`

# Collect and display the number of commands executed with the sudo program:

SUDO_CNT=`cat /var/log/sudo/sudo.log | wc -l | awk '{print ($f1/2)}'`

# Send system information message to all terminals of the server:

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

# Notes:

# - You need to install sysstat package in order to use 'iostat' command.
# - You need to install netstat package in order to use 'netstat' command;
# alternatively, you may to substitute 'netstat' by 'ss -l'.
# - You need to configure your sudoers file via 'sudo visudo' in order to get 
# the number of commands executed with the sudo program;
# to do that, follow the steps bellow:
# 1) 'sudo mkdir /var/log/sudo/sudo.log'
# 2) Open your sudoers file with 'sudo visudo':
# 3) Add the following lines to the file:
#	Defaults        logfile="/var/log/sudo/sudo.log"
#	Defaults        log_input,log_output
#	Defaults        iolog_dir="/var/log/sudo"
