#!/bin/bash
# This script enabled us to locate the given label as argument whether it exists on each node and show it.
echo "Labels selection"

if [ "$1" == "" ] ; then 
    echo "No argument for label name is given"
    echo "Usage: ./labels.sh <argument>"
    exit
else
arg=$1
first=$(docker node inspect mongodb-prd01 | grep Labels -A10 |grep $arg)
    if [ "$first" != "" ] ; then 
        echo '============================'
        echo 'mongodb-prd01'
        echo "$first"
    fi
second=$(docker node inspect mongodb-prd02 | grep Labels -A10 |grep $arg)
    if [ "$second" != "" ] ; then
        echo '============================'
        echo 'mongodb-prd02'
        echo "$second"
    fi
third=$(docker node inspect mongodb-arb | grep Labels -A10 |grep $arg)
    if [ "$third" != "" ] ; then
        echo '============================'
        echo 'mongodb-arb'
        echo "$third"
    fi
fourth=$(docker node inspect sw-swarm-prd-worker01 | grep Labels -A10 |grep $arg)
    if [ "$fourth" != "" ] ; then
        echo '============================'
        echo 'sw-swarm-prd-worker01'
        echo "$fourth"
    fi
fifth=$(docker node inspect sw-swarm-prd-worker02 | grep Labels -A10 |grep $arg)
    if [ "$fifth" != "" ] ; then
        echo '============================'
        echo 'sw-swarm-prd-worker02'
        echo "$fifth"
    fi
sixth=$(docker node inspect sw-swarm-prd-worker03 | grep Labels -A10 |grep $arg)
    if [ "$sixth" != "" ] ; then 
        echo '============================'
        echo 'sw-swarm-prd-worker03'
        echo "$sixth"
    fi
seventh=$(docker node inspect sw-swarm-prd-worker04 | grep Labels -A10 |grep $arg)
    if [ "$seventh" != "" ] ; then 
        echo '============================'
        echo 'sw-swarm-prd-worker04'
        echo "$seventh"
    fi
eightth=$(docker node inspect sw-swarm-prd-worker05 | grep Labels -A10 |grep $arg)
    if [ "$eightth" != "" ] ; then 
        echo '============================'
        echo 'sw-swarm-prd-worker05'
        echo "$eightth"
    fi
nineth=$(docker node inspect sw-swarm-prd-worker06 | grep Labels -A10 |grep $arg)
    if [ "$nineth" != "" ] ; then 
        echo '============================'
        echo 'sw-swarm-prd-worker06'
        echo "$nineth"
    fi

fi