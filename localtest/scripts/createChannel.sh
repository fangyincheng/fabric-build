#!/bin/bash

echo "create==================================="
export FABRIC_CFG_PATH=./data/peer1.org1.com/config
peer channel create -o orderer1.ordererorg.com:7050 -c onechannel --ordererTLSHostnameOverride orderer1.ordererorg.com -f ./channel-artifacts/oneChannel.tx --outputBlock ./channel-artifacts/oneChannel.block --tls true --cafile ../../../crypto/ordererOrganizations/ordererorg.com/orderers/orderer1.ordererorg.com/tls/ca.crt

echo "join==================================="
export  CORE_PEER_ADDRESS=peer1.org1.com:7051
peer channel join -b ./channel-artifacts/oneChannel.block

echo "join==================================="
export FABRIC_CFG_PATH=./data/peer2.org1.com/config
export CORE_PEER_ADDRESS=peer2.org1.com:7051
peer channel join -b ./channel-artifacts/oneChannel.block

echo "update==================================="
export FABRIC_CFG_PATH=./data/peer1.org1.com/config
export  CORE_PEER_ADDRESS=peer1.org1.com:7051
peer channel update -o orderer1.ordererorg.com:7050 --ordererTLSHostnameOverride orderer1.ordererorg.com -c onechannel -f ./channel-artifacts/oneChannelOrg1MSPanchors.tx --tls trur --cafile ../../../crypto/ordererOrganizations/ordererorg.com/orderers/orderer1.ordererorg.com/tls/ca.crt
