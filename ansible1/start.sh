#!/bin/bash

docker build -t jkedra/ansible .
docker container run --rm -v `pwd`:`pwd` -w `pwd` -ti jkedra/ansible
