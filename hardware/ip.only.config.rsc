
# gors@gors-A:~/gors$ scp hardware/ip.only.config.rsc m-r1:/.
# /system reset-configuration skip-backup=yes keep-users=yes run-after-reset=ip.only.config.rsc
:delay 15s
/ip address add address=192.168.88.2/24 comment="management" interface=ether2