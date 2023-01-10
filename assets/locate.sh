#!/bin/bash
#This script accepts as an argument the service stack name and returns on wich nodes its running.
#Example : bash locate.sh activemq-artemis
echo "Service stack location services selection"

if [ "$1" == "" ] ; then 
    echo "No argument for service stack name is given"
    echo "Usage: ./locate.sh <argument>
    exit
else

    docker stack ps $1    |grep Running
 
fi