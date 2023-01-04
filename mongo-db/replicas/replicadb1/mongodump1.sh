#!/bin/bash

mongodb1ContainerName=$(docker ps --format "{{.Names}}" | grep "mongo5-service_mongodb1")

#1) --db can be commented out to include every database
#2) we can set a backup for each day for a week
docker exec -i $mongodb1ContainerName /usr/bin/mongodump -h mongodb1:40001  \
--username adminGenerali \
--password adminGeneraliPass \
--authenticationDatabase admin \
--out /data/db/backup

rsync -avEAX /opt/docker-volumes/mongo5/mongodb1/data/db/backup /opt/docker-volumes/nfs/mongo5/mongodb1