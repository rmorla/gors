#!/bin/bash
scp $2 $1:/reset.config.rsc
ssh $1 '/system reset-configuration skip-backup=yes keep-users=yes run-after-reset=reset.config.rsc'
