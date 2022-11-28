#!/bin/bash

echo "Starting replica set initialize"
until mongo --host mongodb1 --eval "print(\"waited for connection\")"
do
    sleep 2
done
echo "Connection finished"
echo "Creating replica set"
do=true
foo=$(cat /var/log/syslog | grep -c "replica set created")
while $do;
do
do=false

mongo --host mongodb1 <<EOF
rs.initiate(
  {
    _id : 'rs0',
    members: [
      { _id : 0, host : "mongodb1:27017" },
      { _id : 1, host : "mongodb2:27017" },
      { _id : 2, host : "mongodb3:27017", arbiterOnly: true }
    ]
  }
)
EOF
echo "replica set created"

foo=$(cat /var/log/syslog | grep -c "replica set created")
# your code ...
if($foo == 1);
then
break;
fi;

done