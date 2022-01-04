export GORS_HOME=`pwd`
ssh gors-target 'rm -rf ~/quagga'
scp -r $GORS_HOME/org1-ospf/quagga gors-target:~/.
$GORS_HOME/docker-prune.sh
$GORS_HOME/runremote.sh gors-target $GORS_HOME/org1-ospf/routing-twopeers.sh