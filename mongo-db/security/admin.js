// admin.js
admin = db.getSiblingDB("admin")
// creation of the admin user
admin.createUser(
  {
    user: "root",
    pwd: "rootpass",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
// let's authenticate to create the other user
db.getSiblingDB("root").auth("cristian", "rootpass" )
// creation of the replica set admin user
db.getSiblingDB("admin").createUser(
  {
    "user" : "replicaAdmin",
    "pwd" : "replicaAdminPassword",
    roles: [ { "role" : "clusterAdmin", "db" : "admin" } ]
  }
)