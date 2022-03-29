#!/bin/bash
DATE=`date +%Y-%m-%d -d "1 day ago"`
for i in `ls /home/logs/logs/*.log|grep -v $DATE`; do
          pigz $i
done

