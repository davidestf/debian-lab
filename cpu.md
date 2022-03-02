#find which Process is causing High CPU usage
ps -eo pcpu,pid,user,args | sort -k1 -r -n | head -10


#systemctl status 
nano /etc/systemd/system.conf

DefaultMemoryAccounting = yes
DefaultCPUAccounting = yes

systemctl daemon-reexec
