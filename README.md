# Docker Cassandra Cluster (dcc)
Clean and simple docker-compose Cassandra cluster with persistent storage for data.

Based on [official docker image](https://hub.docker.com/_/cassandra/)

## Quick start
```
docker-compose up -d
```
That will bring up a simple Cassandra cluster consisting of 3 nodes: `cass1`, `cass2`, `cass3`

The data will be stored under `./data/` and kept even if the cluster is destroyed.

If you want to start fresh again:
```
sudo rm -r ./data/*
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
Some basic Cassandra configuration can be done through `CASSANDRA_` environment  variables in [docker-compose.yml](docker-compose.yml)

