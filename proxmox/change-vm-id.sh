

export pvepve=vg-images newVMID=102 oldVMID=103 ;  \
for i in $(lvs -a|grep $pve | awk '{print $1}' | grep $oldVMID); \
do lvrename $pve/vm-$oldVMID-disk-$(echo $i | awk '{print substr($0,length,1)}') vm-$newVMID-disk-$(echo $i | awk '{print substr($0,length,1)}'); done; \
sed -i "s/$oldVMID/$newVMID/g" /etc/pve/qemu-server/$oldVMID.conf; mv /etc/pve/qemu-server/$oldVMID.conf /etc/pve/qemu-server/$newVMID.conf; \
unset pve 102 103;

