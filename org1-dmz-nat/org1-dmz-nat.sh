#!/bin/bash

echo ">>>>> networks"
# public network
sudo docker network create public_net --subnet=172.31.255.0/24 --gateway=172.31.255.254
# public network of org1 (DMZ)
sudo docker network create dmz_net --subnet=172.16.123.128/28 --gateway=172.16.123.129
# private networks of org1
sudo docker network create client_net --subnet=10.0.1.0/24 --gateway=10.0.1.1
sudo docker network create server_net --subnet=10.0.2.0/24 --gateway=10.0.2.1

# client and server
echo ">>>>> client and server"
sudo docker run -d --net client_net --ip 10.0.1.100 --cap-add=NET_ADMIN --name client netubuntu 
sudo docker exec client /bin/bash -c 'ip r del default via 10.0.1.1'
sudo docker exec client /bin/bash -c 'ip r a 10.0.2.0/24 via 10.0.1.254'
sudo docker exec client /bin/bash -c 'ip r a default via 10.0.1.254'
sudo docker run -d --net server_net --ip 10.0.2.100 --cap-add=NET_ADMIN --name server netubuntu 
sudo docker exec server /bin/bash -c 'ip r del default via 10.0.2.1'
sudo docker exec server /bin/bash -c 'ip r a 10.0.1.0/24 via 10.0.2.254'
sudo docker exec server /bin/bash -c 'ip r a default via 10.0.2.254'
sudo docker run -d --net dmz_net --ip 172.16.123.130 --cap-add=NET_ADMIN --name public_server netubuntu 
sudo docker exec public_server /bin/bash -c 'ip r del default via 172.16.123.129'
sudo docker exec public_server /bin/bash -c 'ip r a default via 172.16.123.139'
sudo docker exec public_server /bin/bash -c 'ip r a 10.0.0.0/8 via 172.16.123.142'

# internal router
echo ">>>>> internal router"
sudo docker run -d --net client_net --ip 10.0.1.254 --cap-add=NET_ADMIN --name router netubuntu 
sudo docker network connect server_net router --ip 10.0.2.254
sudo docker network connect dmz_net router --ip 172.16.123.142
sudo docker exec router /bin/bash -c 'ip r d default via 10.0.1.1'
sudo docker exec router /bin/bash -c 'ip r a default via 172.16.123.139'

# external router
echo ">>>>> external router"
sudo docker run -d --rm --net dmz_net --ip 172.16.123.139 --cap-add=NET_ADMIN --name edgerouter netubuntu 
sudo docker network connect public_net edgerouter --ip 172.31.255.253
sudo docker exec edgerouter /bin/bash -c 'ip r d default via 172.16.123.129'
sudo docker exec edgerouter /bin/bash -c 'ip r a default via 172.31.255.254'
sudo docker exec edgerouter /bin/bash -c 'ip r a 10.0.0.0/8 via 172.16.123.142'
sudo docker exec edgerouter /bin/bash -c 'iptables -t nat -F; iptables -t filter -F'
sudo docker exec edgerouter /bin/bash -c 'iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth1 -j MASQUERADE'
sudo docker exec edgerouter /bin/bash -c 'iptables -t filter -P FORWARD DROP'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state NEW -i eth0 -j ACCEPT'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state NEW -i eth1 -d 172.16.123.128/28 -j ACCEPT'

# external host
echo ">>>>> external host"
sudo docker run -d --rm --net public_net --ip 172.31.255.101 --cap-add=NET_ADMIN --name externalhost netubuntu 
sudo docker exec externalhost /bin/bash -c 'ip r a 10.0.0.0/8 via 172.31.255.253'
sudo docker exec externalhost /bin/bash -c 'ip r a 172.16.123.128/28 via 172.31.255.253'


