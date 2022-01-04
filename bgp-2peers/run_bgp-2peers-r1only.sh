#!/bin/bash
export GORS_HOME=`pwd`

ssh gors-target 'sudo docker kill org1_router1; sudo docker rm org1_router1'
ssh gors-target 'sudo docker kill org2_router1; sudo docker rm org2_router1'
ssh gors-target 'sudo rm -rf quagga'
scp -r $GORS_HOME/bgp-2peers/quagga gors-target:~/.

$GORS_HOME/runremote.sh gors-target $GORS_HOME/bgp-2peers/bgp-2peers-r1only.sh