#!/bin/bash



# org1 routers
echo ">>>>R1.1"
sudo docker run -d --net org1_int1_net --ip 10.0.1.2 \
    -v /home/gors/quagga/zebra.conf:/etc/quagga/zebra.conf \
    -v /home/gors/quagga/ospfd.conf:/etc/quagga/ospfd.conf \
    -v /home/gors/quagga/bgpd-org1.conf:/etc/quagga/bgpd.conf \
    -v /home/gors/quagga/start-ospf-bgp.sh:/root/start.sh \
    --cap-add=NET_ADMIN  --privileged --name org1_router1 netubuntu 
sudo docker network connect org1_int2_net org1_router1 --ip 10.0.1.10
sudo docker network connect public_net org1_router1 --ip 172.31.255.253
sudo docker exec org1_router1 /bin/bash -c 'ip r del default via 10.0.1.1'



# org2 routers
echo ">>>>R2.1"
sudo docker run -d --net org2_int1_net --ip 10.0.2.2 \
    -v /home/gors/quagga/zebra.conf:/etc/quagga/zebra.conf \
    -v /home/gors/quagga/ospfd.conf:/etc/quagga/ospfd.conf \
    -v /home/gors/quagga/bgpd-org2.conf:/etc/quagga/bgpd.conf \
    -v /home/gors/quagga/start-ospf-bgp.sh:/root/start.sh \
    --cap-add=NET_ADMIN  --privileged --name org2_router1 netubuntu 
sudo docker network connect org2_int2_net org2_router1 --ip 10.0.2.10
sudo docker network connect public_net org2_router1 --ip 172.31.255.252
sudo docker exec org2_router1 /bin/bash -c 'ip r del default via 10.0.2.1'
#sudo docker exec org2_router1 /bin/bash -c 'ip r add default via 172.31.255.1'
