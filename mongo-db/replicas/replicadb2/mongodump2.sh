#!/bin/bash

mongodb2ContainerName=$(docker ps --format "{{.Names}}" | grep "mongo5-service_mongodb2")

#1) --db can be commented out to include every database
#2) we can set a backup for each day for a week
docker exec -i $mongodb2ContainerName /usr/bin/mongodump -h mongodb2:40002  \
--username adminGenerali \
--password adminGeneraliPass \
--authenticationDatabase admin \
--db admin \
--out /data/db/backup

rsync -avEAX /opt/docker-volumes/mongo5/mongodb2/data/db/backup /opt/docker-volumes/nfs/mongo5/mongodb2