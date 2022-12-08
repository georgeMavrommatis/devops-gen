#!/bin/bash
docker login -u admin -p JMfbh8E6SRJVpBGfzL6W sw-nexus:9001
docker image push sw-nexus:9001/mongo5_replicadb2:1.0.0