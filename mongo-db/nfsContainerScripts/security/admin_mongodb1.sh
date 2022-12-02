console.log("---> Starting admin_mongodb1 script <---");

#enter admin db
db.getSiblingDB("admin")

if(rs.isMaster().info == "Does not have a valid replica set config"){
    //initialize replicas
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
    console.log("Waiting for initialization...");
    setTimeout(() => {  console.log("Replicas initialized...!"); }, 5000);
}

if(!rs.isMaster().ismaster){
    console.log("Server not master process terminating...");
    process.exit(0);
}

console.log("Creation of the admin user...");

admin.createUser(
  {
    user: "generali",
    pwd: "generalipass",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)

// let's authenticate to create the other user
db.getSiblingDB("admin").auth("generali", "generalipass" )

console.log("Creation of the replica set admin user...");
db.getSiblingDB("admin").createUser(
  {
    "user" : "replicaAdmin",
    "pwd" : "generalipass",
    roles: [ { "role" : "clusterAdmin", "db" : "admin" } ]
  }
)
