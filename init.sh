#!/bin/bash

set -u

echo "Running docker compose"
docker-compose up -d


# Mongo Config replica set (1 node)
echo "Configuring MongoDB config replica"
docker-compose exec configsvr01 sh -c "/scripts/wait-connection.sh configsvr01"
docker-compose exec configsvr01 sh -c "mongo --quiet < /scripts/init-configserver.js"

# Mongo shards (1 node each)
echo "Configuring MongoDB shard replicas"

docker-compose exec shard01-a sh -c "/scripts/wait-connection.sh shard01-a"
docker-compose exec shard01-a sh -c "mongo --quiet < /scripts/init-shard01.js"

docker-compose exec shard02-a sh -c "/scripts/wait-connection.sh shard02-a"
docker-compose exec shard02-a sh -c "mongo --quiet < /scripts/init-shard02.js"

docker-compose exec shard03-a sh -c "/scripts/wait-connection.sh shard03-a"
docker-compose exec shard03-a sh -c "mongo --quiet < /scripts/init-shard03.js"

# Initialize Mongo router
echo "Configuring MongoDB router"

docker-compose exec router01 sh -c "/scripts/wait-connection.sh router01"
docker-compose exec router01 sh -c "mongo --quiet < /scripts/init-router.js"

echo "Configuring MongoDB WildDuck sharding"
docker-compose exec router01 sh -c "mongo --quiet < /scripts/init-sharding.js"

echo "Checking sharding status"
docker-compose exec router01 sh -c "mongo --eval 'sh.status()'"

echo "All done"