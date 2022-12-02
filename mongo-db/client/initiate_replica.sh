#!/bin/bash

echo "Starting replica set initialize"

var=0
until mongosh --host mongodb1 --eval "print(\"waited for connection\")"; do
  sleep 2
  var=$((var + 1))
  echo "var =" $var
  if [[ var -eq 10 ]]; then
    echo "-->Error!!! Unable to connect to mongodb1 via overlay Newtork!!!<--"
    exit 0
  fi
done
echo "-->Connected to mongodb1<--"

var=0
until mongosh --host mongodb2 --eval "print(\"waited for connection\")"; do
  sleep 2
  var=$((var + 1))
  echo "var =" $var
  if [[ var -eq 10 ]]; then
    echo "-->Error!!! Unable to connect to mongodb2 via overlay Newtork!!!<--"
    exit 0
  fi
done
echo "-->Connected to mongodb2<--"

var=0
until mongosh --host mongodb_arbiter --eval "print(\"waited for connection\")"; do
  sleep 2
  var=$((var + 1))
  echo "var =" $var
  if [[ var -eq 10 ]]; then
    echo "-->Error!!! Unable to connect to mongodb_arbiter via overlay Newtork!!!<--"
    exit 0
  fi
done
echo "-->Connected to mongodb_arbiter<--"
echo "-->Connection finished<--"

#fetch response of who is primary
request=$(
  mongo --host mongodb1 <<EOF
rs.isMaster().primary
EOF
)

#remove new line characters
request=${request//$'\n'/}

echo "Locate Primary Server via connection -->"
echo $request
echo "<--"

if [[ $request == *"mongodb1:27017bye"* ]]; then
  primaryServer="mongodb1"
elif [[ $request == *"mongodb2:27017bye"* ]]; then
  primaryServer="mongodb2"
elif [[ $request == *"================bye"* ]]; then
  primaryServer="mongodb1"
else
  echo "Error!!! no Primary Server detected!!!"
  exit 0
fi

#Print message based on the value of $passed
echo "------> Primary Server: " $primaryServer

echo "Creating replica set"
mongo --host $primaryServer <<EOF
rs.initiate(
  {
    _id : 'rs0',
    members: [
      { _id : 0, host : "mongodb1:27017", arbiterOnly: false },
      { _id : 1, host : "mongodb2:27017", arbiterOnly: false },
      { _id : 2, host : "mongodb_arbiter:27017", arbiterOnly: true }
    ]
  }
)
EOF
echo "----------> Replica set created in "$primaryServer"<----------"
echo "----------> Connect to primary server via a mongo container and execute mongosh, rs.status() to view All initialized members<----------"
echo "----------> Connect to primary server via a mongo container and execute mongosh, rs.status() to view All initialized members<----------"
echo "----------> 1) docker run --rm -it --net mongo5-service_alphanetwork sw-nexus:9001/mongo5_arbiter:1.0.0 bash<----------"
echo "----------> 2) mongosh --host "$primaryServer"<----------"
echo "----------> 3) rs.status()<----------"
