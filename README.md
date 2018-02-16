# Docker Cassandra Cluster (dcc)
Clean and simple docker-compose Cassandra cluster with persistent storage for data.

This approach is based on [official docker image](https://hub.docker.com/_/cassandra/), but still lets you control all the config files without a need to build a custom image. Which is described in more details in this [blog post](https://digitalis.io/blog/)

## Quick start
```
./setup-config.sh
docker-compose up -d

# ./setup-config.sh doesn't work on MacOS atm, because Mac version of docker command line doesn't allow passing variables
# in order to fix it, replace all instances of ${CASSANDRA_VERSION} in the script with an explicit version number
```
   - That will bring up a 3 node Cassandra cluster. Note: it will require ~6G of RAM free for 3 nodes
   - The data will be stored under `./data/` and kept even if the cluster is destroyed
   - Cassandra configuration files will be stored under `./etc/`
   - You can access the cluster from your app on `localhost:9042, localhost:9043, localhost:9044` 
   - Or can add a container with your app to [docker-compose.yml](docker-compose.yml)

If you want to start fresh again:
```
sudo rm -r ./data/* ./etc/*
```

## Destroying the cluster
```
docker-compose down
```

## nodetool
```
docker exec cass1 nodetool status
```

## cqlsh
```
docker exec cass1 cqlsh -e "DESCRIBE keyspaces;"

# Or in interactive shell mode
docker exec -it cass1 cqlsh
```

## Cassandra logs
```
docker logs -f cass1
```

## Basic configuration
Edit [docker-compose.yml](docker-compose.yml) for your needs, keeping in mind the following:

   - An [official docker image](https://hub.docker.com/_/cassandra/) for cassandra must be used
   - You should specify an explicit version tag
   - Each cassandra container needs to have two volumes configured, one for data and one for config files
   - Some basic Cassandra configuration can be done through `CASSANDRA_` environment  variables
   - Check the syntax with `docker-compose config` before running `./setup-config.sh`

## Advanced configuration
If you need more advanced configuration, you can edit config files (eg. cassandra.yaml) for each node under `etc/<node>/`

Some practical examples can be found in this [blog post](https://digitalis.io/blog/)
