#!/bin/bash
docker service logs mongo5-service_mongoclient | grep "replica set created" -B 15