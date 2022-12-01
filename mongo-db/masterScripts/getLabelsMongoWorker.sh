#!/bin/bash
echo 'mongodb-prd01'
docker node inspect mongodb-prd01 | grep Labels -A $1
echo 'mongodb-prd02'
docker node inspect mongodb-prd02 | grep Labels -A $1
echo 'mongodb-arb'
docker node inspect mongodb-arb | grep Labels -A $1
