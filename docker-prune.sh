#!/bin/bash
ssh gors-B 'sudo docker kill `docker ps -aq`'
ssh gors-B 'sudo docker rm `docker ps -aq`'
ssh gors-B 'sudo docker system prune -f'