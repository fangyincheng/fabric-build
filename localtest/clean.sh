#!/bin/bash

docker service rm $(docker service ls | awk '{printf $1 "\n"}')

rm -rf ./channel-artifacts/*
rm -rf ./crypto-config

for j in `ls ./data`
do
echo $j
rm -rf ./data/$j
mkdir ./data/$j
done