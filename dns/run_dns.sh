#!/bin/bash
export GORS_HOME=`pwd`
ssh gors-target 'sudo docker kill bind9_myorg_auth'
ssh gors-target 'sudo rm -rf etcbind'

scp -r $GORS_HOME/dns/etcbind gors-target:~/.
./runremote.sh gors-target $GORS_HOME/dns/dns.sh