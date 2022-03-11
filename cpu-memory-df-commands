## CPU
### find which Process is causing High CPU usage
ps -eo pcpu,pid,user,args | sort -k1 -r -n | head -10


#systemctl status 
nano /etc/systemd/system.conf

DefaultMemoryAccounting = yes
DefaultCPUAccounting = yes

systemctl daemon-reexec


## Memory
grep -i -r 'out of memory' /var/log/

free -h

vmstat -s
less /proc/meminfo

ps aux
ps -o pid,user,%mem,command ax | sort -b -k3 -r


clear cache
echo 3 > /proc/sys/vm/drop_caches

### memory overcommit /etc/sysctl.conf
sysctl -w vm.overcommit_memory=2
sysctl -w vm.overcommit_ratio=100

 
### check disk space

df -h
du -hs /var/
ls -lh /var/log/mail.log


