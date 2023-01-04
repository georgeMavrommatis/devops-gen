#!/bin/bash

if [ "$1" == "" ] ; then 
    echo "No argument for service stack name is given"
    echo "Usage: ./locate.sh <argument>"
    exit
else

    docker stack ps $1    |grep Running
 
fi