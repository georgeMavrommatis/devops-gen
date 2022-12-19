#!/bin/bash

mongodb1ContainerName=$(docker ps --format "{{.Names}}" | grep "mongo5-service_mongodb1")

cp -R /opt/docker-volumes/nfs/mongo5/mongodb1/data/db/backup /opt/docker-volumes/mongo5/mongodb1/data/db

docker exec -i $mongodb1ContainerName /usr/bin/mongorestore \
--host mongodb1:40001 \
--username adminGenerali \
--password adminGeneraliPass \
--authenticationDatabase admin \
--db admin /data/db/backup/admin