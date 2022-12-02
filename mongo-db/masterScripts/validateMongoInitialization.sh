#!/bin/bash
docker service logs mongo5-service_mongoclient | grep "Starting replica set initialize" -A 500