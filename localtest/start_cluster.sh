#!/bin/bash

docker stack deploy -c ./zookeeper-docker.yaml hyperledger
docker stack deploy -c ./kafka-docker.yaml hyperledger
docker stack deploy -c ./orderer-docker.yaml hyperledger
docker stack deploy -c ./org-docker.yaml hyperledger
# docker stack deploy -c ./cli-docker.yaml hyperledger
# docker stack deploy -c ./explorer-docker.yaml hyperledger
# docker stack deploy -c ./restapi-docker.yaml hyperledger
