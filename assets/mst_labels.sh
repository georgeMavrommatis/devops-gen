#!/bin/bash
# This script enabled us to locate the given label as argument whether it exists on each node and show it.
echo "Labels selection"

if [ "$1" == "" ] ; then 
    echo "No argument for label name is given"
    echo "Usage: ./labels.sh <argument>"
    exit
else

arg=$1

first=$(docker node inspect sw-swarm-prd-mgr01 | grep Labels -A10 |grep $arg)
    if [ "$first" != "" ] ; then
        echo '============================'
        echo 'sw-swarm-prd-mgr01'
        echo "$first"
    fi
second=$(docker node inspect sw-swarm-prd-mgr02 | grep Labels -A10 |grep $arg)   

    if [ "$second" != "" ] ; then
        echo '============================'
        echo 'sw-swarm-prd-mgr02'
        echo "$second"
    fi

third=$(docker node inspect sw-swarm-prd-mgr03 | grep Labels -A10 |grep $arg)
    
    if [ "$third" != "" ] ; then \
        echo '============================'
        echo 'sw-swarm-prd-mgr03'
        echo "$third"
    fi

fi