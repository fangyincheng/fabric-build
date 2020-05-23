#!/bin/bash

echo "========== Package a chaincode =========="
export FABRIC_CFG_PATH=./data/peer1.org1.com/config
export CORE_PEER_ADDRESS=peer1.org1.com:7051
peer lifecycle chaincode package fabcar.tar.gz --path ./chaincode/fabcar/go/ --lang golang --label fabcar_1.0

echo "========== Installing chaincode on peer1.org1 =========="
export FABRIC_CFG_PATH=./data/peer1.org1.com/config
export CORE_PEER_ADDRESS=peer1.org1.com:7051
peer lifecycle chaincode install fabcar.tar.gz

echo "========== Installing chaincode on peer2.org1 =========="
export FABRIC_CFG_PATH=./data/peer2.org1.com/config
export CORE_PEER_ADDRESS=peer2.org1.com:7051
peer lifecycle chaincode install fabcar.tar.gz

echo "========== Query chaincode package ID =========="
export FABRIC_CFG_PATH=./data/peer1.org1.com/config
export CORE_PEER_ADDRESS=peer1.org1.com:7051
peer lifecycle chaincode queryinstalled >&log.txt
export PACKAGE_ID=`sed -n '/Package/{s/^Package ID: //; s/, Label:.*$//; p;}' log.txt`

echo "========== Approve definition for Org1 =========="
export CORE_PEER_ADDRESS=peer1.org1.com:7051
peer lifecycle chaincode approveformyorg -o orderer1.ordererorg.com:7050 --ordererTLSHostnameOverride orderer1.ordererorg.com --tls true --cafile ../../../crypto/ordererOrganizations/ordererorg.com/orderers/orderer1.ordererorg.com/tls/ca.crt --channelID onechannel --signature-policy "OR('Org1MSP.peer')" --name fabcar --version 1.0 --init-required --package-id ${PACKAGE_ID} --sequence 1

peer lifecycle chaincode checkcommitreadiness --channelID onechannel --name fabcar --signature-policy "OR('Org1MSP.peer')" --version 1.0 --init-required --sequence 1 >&log.txt

echo "========== Commit the definition the onechannel =========="
peer lifecycle chaincode commit -o orderer1.ordererorg.com:7050 --ordererTLSHostnameOverride orderer1.ordererorg.com --tls true --cafile ../../../crypto/ordererOrganizations/ordererorg.com/orderers/orderer1.ordererorg.com/tls/ca.crt --channelID onechannel --signature-policy "OR('Org1MSP.peer')" --name fabcar --version 1.0 --init-required --sequence 1 --waitForEvent --peerAddresses peer1.org1.com:7051  --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.com/peers/peer1.org1.com/tls/ca.crt


echo "========== Invoke the Init function =========="
peer chaincode invoke -o orderer1.ordererorg.com:7050 --ordererTLSHostnameOverride orderer1.ordererorg.com --tls true --cafile ../../../crypto/ordererOrganizations/ordererorg.com/orderers/orderer1.ordererorg.com/tls/ca.crt  -C onechannel -n fabcar --isInit -c '{"Args":["InitLedger"]}'

sleep 3

echo "========== Invoke the Init function =========="
peer chaincode invoke -o orderer1.ordererorg.com:7050 --ordererTLSHostnameOverride orderer1.ordererorg.com --tls true --cafile ../../../crypto/ordererOrganizations/ordererorg.com/orderers/orderer1.ordererorg.com/tls/ca.crt  -C onechannel -n fabcar -c '{"Args":["QueryCar", "a"]}'
