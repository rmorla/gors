#https://wiki.ubuntu.com/JonathanFerguson/Quagga
# zebra: telnet localhost 2601 
# ospfv2: telnet localhost 2604
# bgp: telnet localhost 2605


systemctl start zebra
systemctl start ospfd
/root/sleep.sh
