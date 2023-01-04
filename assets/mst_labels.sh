#!/bin/bash
# This script enabled us to locate the given label as argument whether it exists on each node and show it.
echo "Labels selection"

if [ "$1" == "" ] ; then 
    echo "No argument for label name is given"
    echo "Usage: ./labels.sh <argument>"
    exit
else

arg=$1

echo 'sw-swarm-prd-mgr01'
docker node inspect mongodb-prd01 | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-mgr02'
docker node inspect mongodb-prd02 | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-mgr03'
docker node inspect mongodb-arb | grep Labels -A10 |grep $arg
echo '============================'

fi