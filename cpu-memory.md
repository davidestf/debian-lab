##CPU
#find which Process is causing High CPU usage
ps -eo pcpu,pid,user,args | sort -k1 -r -n | head -10


#systemctl status 
nano /etc/systemd/system.conf

DefaultMemoryAccounting = yes
DefaultCPUAccounting = yes

systemctl daemon-reexec


##Memory
grep -i -r 'out of memory' /var/log/

free -h

vmstat -s
less /proc/meminfo

ps aux
ps -o pid,user,%mem,command ax | sort -b -k3 -r
