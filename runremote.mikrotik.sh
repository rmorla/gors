#!/bin/bash
scp $2 $1:/scripts.to.run
ssh $1 '/import /scripts.to.run'
