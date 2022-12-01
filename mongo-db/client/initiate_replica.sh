#!/bin/bash

echo "Starting replica set initialize"
#docker run --rm -it mongo:5 mongo --port 30001 --host sw-swarm-prd-mgr03
#until mongo --port 30001 --host sw-swarm-prd-mgr03 --eval "print(\"waited for connection\")"
until mongo --host mongodb1 --eval "print(\"waited for connection\")"
do
    sleep 2
done

echo "Connection finished"
echo "Creating replica set"
mongo --host mongodb1 <<EOF
rs.initiate(
  {
    _id : 'rs0',
    members: [
      { _id : 0, host : "mongodb1:27017" },
      { _id : 1, host : "mongodb2:27017" },
      { _id : 2, host : "mongo_arbiter:27017", arbiterOnly: true }
    ]
  }
)
EOF
echo "----------> replica set created <----------"

mongo --host mongodb1 <<EOF
rs.addArb("mongo_arbiter:27017")
EOF
echo "----------> Arbiter Added <----------"