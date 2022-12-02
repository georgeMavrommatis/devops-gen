serverName="mongodb1"

echo "Starting replica set initialize"

var=0
until mongosh --host $serverName --eval "print(\"waited for connection\")"; do
  sleep 2
  var=$((var + 1))
  if [[ var -eq 10 ]]; then
    echo "-->Error!!! Unable to connect to mongodb1 via overlay Newtork!!!<--"
    exit 0
  fi
  echo "--> Attemp #"$var" for Connection with "$serverName "..."
done
echo "-->Connected to mongodb1<--"

statusReport=$(mongosh --host $serverName <<EOF
rs.isMaster().info
EOF
)

request=${statusReport//$'\n'/}
echo "result: "$statusReport

if [[ $request == *"Does not have a valid replica set config"* ]]; then

  echo "Waiting 10 seconds before initialization..."
  sleep 10

mongosh <<EOF
db.getSiblingDB("admin")
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

  echo "----------> Replica set created in "$serverName"<----------"
  echo "Waiting 10 seconds before admin user setup..."
  sleep 10
  echo "----------> Creating adminGenerali,replicaAdminGenerali users "$serverName"<----------"

mongosh <<EOF
admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "adminGenerali",
    pwd: "adminGeneraliPass",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
db.getSiblingDB("admin").auth("generali", "generalipass" )
// creation of the replica set admin user
db.getSiblingDB("admin").createUser(
  {
    "user" : "replicaAdminGenerali",
    "pwd" : "replicaAdminGeneraliPass",
    roles: [ { "role" : "clusterAdmin", "db" : "admin" } ]
  }
)
EOF

  echo "----------> Connect to primary server via a mongo container and execute mongosh, rs.status() to view All initialized members<----------"
  echo "----------> 1) docker run --rm -it --net mongo5-service_alphanetwork mongo:5 bash<----------"
  echo "----------> 2) mongosh --host "$serverName" -u USERNAME -p OASSWORD --authenticationDatabase \"admin\" <----------"
  echo "----------> 3) rs.status()<----------"
  echo "or"
  echo "----------> 1) docker run --rm -it mongo:5 bash<----------"
  echo "----------> 2) mongosh --host ANY_SWARM_MANAGER_HOSTNAME:PORT -u USERNAME -p OASSWORD --authenticationDatabase \"admin\" <----------"
  echo "----------> 3) rs.status()<----------"
else
  echo "----------> MongoDB Replicas Cluster Already Initialized !<----------"
fi