#!/bin/bash
ssh gors-target 'sudo docker kill `docker ps -aq`'
ssh gors-target 'sudo docker rm `docker ps -aq`'
ssh gors-target 'sudo docker system prune -f'
ssh gors-target 'sudo rm -rf baseimage quagga'
