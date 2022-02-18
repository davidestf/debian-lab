#!/bin/bash

apt install stress-ng


stress-ng --vm-bytes $(awk '/MemFree/{printf "%d\n", $2 * 0.9;}' < /proc/meminfo)k --vm-keep -m 1


#use MemAvailable instead to estimate available memory for new processes without swapping:
#stress-ng --vm-bytes $(awk '/MemAvailable/{printf "%d\n", $2 * 0.9;}' < /proc/meminfo)k --vm-keep -m 1



# sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/dstf/debian-lab/main/stress-ng.sh)"
