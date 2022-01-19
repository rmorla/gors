echo ">>"
sudo docker exec org1_router1 /bin/bash -c 'ip r'
echo ">>"
sudo docker exec org2_router1 /bin/bash -c 'ip r'
echo ">>"
sudo docker exec org2_server1 /bin/bash -c 'ping -c 3 172.16.123.146'
echo ">>"
sudo docker exec org1_server1 /bin/bash -c 'ping -c 3 172.16.123.2'

