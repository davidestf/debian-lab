#!/bin/sh


# DELETE older than 1 day
find /var/log/ -mtime +1 | xargs  -n1 rm -rf
