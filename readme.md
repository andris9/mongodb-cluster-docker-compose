# Mongo Sharded Cluster with Docker Compose

Forked from https://github.com/minhhungit/mongodb-cluster-docker-compose/

The following command runs the following procedures:

- Starts mongodb cluster with docker-compose
- Setups MongoDB config replica set
- Setups MongoDB shard replicas
- Setups MongoDB router
- Sets up WildDuck sharding

```
$ ./init.sh
```

Next, edit WildDuck database config with the following options:

```toml
mongo = "mongodb://127.0.0.1:27117/wildduck"
gridfs = "attachments"
users = "users"
sender = "zonemta"
```
