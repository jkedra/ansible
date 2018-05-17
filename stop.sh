#!/bin/bash

MACHINES_RUNNING=$(docker-machine ls --filter 'state=Running' -f '{{.Name}}')

echo Machines to stop: $MACHINES_RUNNING

for machine in $MACHINES_RUNNING;
do
    echo stopping $machine
    docker-machine stop $machine
done

docker-machine ls
