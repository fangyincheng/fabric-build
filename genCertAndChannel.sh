#!/bin/bash

./bin/cryptogen generate --config=./crypto-config.yaml

./bin/configtxgen -profile SystemChannel -channelID system-channel -outputBlock ./channel-artifacts/genesis.block

./bin/configtxgen -profile OneOrgsChannel -outputCreateChannelTx ./channel-artifacts/oneChannel.tx -channelID onechannel

./bin/configtxgen -profile OneOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/oneChannelOrg1MSPanchors.tx -channelID onechannel -asOrg Org1MSP


./bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/twoChannel.tx -channelID twochannel

./bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/twoChannelOrg1MSPanchors.tx -channelID twochannel -asOrg Org1MSP

./bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/twoChannelOrg2MSPanchors.tx -channelID twochannel -asOrg Org2MSP

mkdir ./data/peer1.org1.com/config
mkdir ./data/peer2.org1.com/config
mkdir ./data/peer1.org1.com/data
mkdir ./data/peer2.org1.com/data
mkdir ./data/expolorer/wallet
mkdir ./data/expolorer/pgdata
cp ./config/core.yaml ./data/peer1.org1.com/config
cp ./config/core.yaml ./data/peer2.org1.com/config
cp -rf ./crypto-config/peerOrganizations/org1.com/peers/peer1.org1.com/msp ./data/peer1.org1.com/config/msp
cp -rf ./crypto-config/peerOrganizations/org1.com/peers/peer1.org1.com/tls ./data/peer1.org1.com/config/tls
cp -rf ./crypto-config/peerOrganizations/org1.com/peers/peer2.org1.com/msp ./data/peer2.org1.com/config/msp
cp -rf ./crypto-config/peerOrganizations/org1.com/peers/peer2.org1.com/tls ./data/peer2.org1.com/config/tls
