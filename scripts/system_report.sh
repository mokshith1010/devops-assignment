#!/bin/bash
echo "System Report: $(date)"
echo "Uptime: $(uptime -p)"
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: ${CPU}%"
MEM=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Memory Usage: ${MEM}%"
DISK=$(df -h / | awk 'NR==2 {print $5}')
echo "Disk Usage: $DISK"
echo "Top 3 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 4
echo ""

DISK=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')
if [ "$DISK" -ge 80 ]; then
    echo "Disk usage is ${DISK}% on $(hostname) at $(date)" | mail -s "ALERT: Disk usage is greater than 80%" mokshith10102@gmail.com
fi
