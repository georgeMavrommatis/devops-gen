#!/bin/bash

mongodb2ContainerName=$(docker ps --format "{{.Names}}" | grep "mongo5-service_mongodb2")

cp -R /opt/docker-volumes/nfs/mongo5/mongodb2/data/db/backup /opt/docker-volumes/mongo5/mongodb2/data/db

docker exec -i $mongodb2ContainerName /usr/bin/mongorestore \
--host mongodb2:40002 \
--username adminGenerali \
--password adminGeneraliPass \
--authenticationDatabase admin \
--db admin /data/db/backup/admin