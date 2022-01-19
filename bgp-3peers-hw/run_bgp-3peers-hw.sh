#!/bin/bash
export GORS_HOME=`pwd`
$GORS_HOME/docker-prune.sh
scp -r $GORS_HOME/bgp-3peers-hw/quagga gors-target:~/.
$GORS_HOME/runremote.sh gors-target $GORS_HOME/bgp-3peers-hw/bgp-3peers-hw.sh