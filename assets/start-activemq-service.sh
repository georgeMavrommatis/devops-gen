#!/bin/bash
echo "Starting Activemq-artemis docker service"

docker stack deploy -c ./docker_compose_bind_mount_no_volumes.yml generali_activemq-artemis
