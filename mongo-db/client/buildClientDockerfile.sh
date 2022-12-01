#!/bin/bash
docker login -u admin -p JMfbh8E6SRJVpBGfzL6W sw-nexus:9001
docker build -t sw-nexus:9001/mongo5_client:1.0.0 .