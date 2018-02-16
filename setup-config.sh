#!/bin/bash
set -e  #fail fast

CASSANDRA_VERSION=`docker-compose config | grep 'image:.*cassandra:' | head -1 | awk -F":" '{ print $NF}'`
docker image pull cassandra:${CASSANDRA_VERSION}

docker run --rm -d --name tmp cassandra:${CASSANDRA_VERSION}
docker cp tmp:/etc/cassandra/ cassandra_${CASSANDRA_VERSION}/
docker stop tmp

etc_volumes=`docker-compose config | grep '/etc/cassandra' | awk -F ":" '{ print $1}' | awk '{ print $NF}'`
for v in ${etc_volumes}; do
   mkdir -p ${v}
   cp -r cassandra_${CASSANDRA_VERSION}/*.* ${v}/
done


