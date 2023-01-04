#!/bin/bash

if [ "$1" == "" ] ; then 
    echo "No argument for label name is given"
    echo "Usage: ./labels.sh <argument>"
    exit
else

echo 'mongodb-prd01'
docker node inspect mongodb-prd01 | grep Labels -A10 |grep $arg
echo '============================'
echo 'mongodb-prd02'
docker node inspect mongodb-prd02 | grep Labels -A10 |grep $arg
echo '============================'
echo 'mongodb-arb'
docker node inspect mongodb-arb | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-worker01'
docker node inspect sw-swarm-prd-worker01 | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-worker02'
docker node inspect sw-swarm-prd-worker02 | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-worker03'
docker node inspect sw-swarm-prd-worker03 | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-worker04'
docker node inspect sw-swarm-prd-worker04 | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-worker05'
docker node inspect sw-swarm-prd-worker05 | grep Labels -A10 |grep $arg
echo '============================'
echo 'sw-swarm-prd-worker06'
docker node inspect sw-swarm-prd-worker06 | grep Labels -A10 |grep $arg

fi