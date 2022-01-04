#!/bin/bash
export GORS_HOME=`pwd`
$GORS_HOME/docker-prune.sh
$GORS_HOME/runremote.sh gors-target $GORS_HOME/org1-dmz-nat/org1-dmz-nat.sh