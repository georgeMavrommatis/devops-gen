#!/bin/bash
echo "Removal for generali_activemq-artemis"

echo "Are you sure you want to remove the service?"
echo "NOTICE: answering yes can potentially lead to loss of data."
echo "yes/no"
read state

if [ $state == yes ] ; then 
    echo "Removing the generali_activemq-artemis service"
    docker stack rm generali_activemq-artemis
elif [ $state == no ] ; then 
 exit
else 
    echo "Invalid argument, please try again"
    ScriptLoc=$(pwd)
    exec "$ScriptLoc/removing-activemq-artemis.sh"

fi

