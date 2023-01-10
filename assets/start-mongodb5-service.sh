#!/bin/bash
echo "Starting Activemq-artemis docker service"

docker stack deploy -c ./docker-compose-mongo5.yml generali_mongodb5-service
