#!/bin/bash

MACHINES_TO_START=$(docker-machine ls --filter 'state=stopped' -f '{{.Name}}')
for machine in $MACHINES_TO_START;
do
    docker-machine start $machine
done

docker-machine ls

eval `docker-machine env node1`

# docker-machine regenerate-certs node2

echo SWARM services:
docker service ls
exit


###################
docker network create --driver overlay backend
docker network create --driver overlay frontend

docker service create --name vote \
    --network frontend \
    --replicas 2 \
    --publish 80:80 \
    dockersamples/examplevotingapp_vote:before

docker service create --name redis \
    --network frontend \
    --replicas 1 \
    redis:3.2

docker service create --name result \
    --publish 5001:80 \
    --replicas 1 \
    --network backend \
    dockersamples/examplevotingapp_result:before

docker service create --name worker \
    --network frontend \
    --network backend \
    --replicas 1 \
    dockersamples/examplevotingapp_worker

docker service create --name result \
    --publish 5001:80 \
    --replicas 1 \
    --network backend \
    dockersamples/examplevotingapp_result:before


# -- docker-compose.yaml
# docker-compose up
# docker-compose ps
# docker-compose down --volumes
# -- optionally
# docker-compose push

# docker stack deploy --compose-file docker-compose.yaml swarm-app-1
# docker stack services swarm-app-1

