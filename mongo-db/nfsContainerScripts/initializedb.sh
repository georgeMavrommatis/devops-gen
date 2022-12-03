#!/bin/bash

mongodb1ContainerName=$(docker ps --format "{{.Names}}" | grep "mongo5-service_mongodb1")
docker exec -it $mongodb1ContainerName bash -c "cd /data/admin/ ; ./admin_mongodb1.sh"
