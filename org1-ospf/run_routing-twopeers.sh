export GORS_HOME=`pwd`
$GORS_HOME/docker-prune.sh
scp -r $GORS_HOME/org1-ospf/quagga gors-target:~/.
$GORS_HOME/runremote.sh gors-target $GORS_HOME/org1-ospf/routing-twopeers.sh