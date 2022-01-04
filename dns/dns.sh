sudo docker run -d \
        --name=bind9_myorg_auth \
        --volume /home/gors/etcbind:/etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --rm --net dmz_net --ip 172.16.123.129  --cap-add=NET_ADMIN \
        internetsystemsconsortium/bind9:9.16
        
        #--restart=always \

sudo docker exec bind9_myorg_auth ip r d  default via 172.16.123.141
sudo docker exec bind9_myorg_auth ip r a  default via 172.16.123.142

sudo docker exec client /bin/bash -c "echo 'nameserver 172.16.123.129' > /etc/resolv.conf"
sudo docker exec server /bin/bash -c "echo 'nameserver 172.16.123.129' > /etc/resolv.conf"
sudo docker exec externalhost /bin/bash -c "echo 'nameserver 172.16.123.129' > /etc/resolv.conf"
