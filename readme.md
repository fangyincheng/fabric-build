* 介绍

可以运行在swarm网络中的fabric2.1网络，包括浏览器和rest api的invoke接口。支持脚本一键创建。

* docker和swarm file的对应关系如下，根据docker版本需要修改yaml文件的version字段

Compose file format	| Docker Engine release
-                   |-
3.8	            	| 19.03.0+
3.7	            	| 18.06.0+
3.6	            	| 18.02.0+
3.5	            	| 17.12.0+
3.4	            	| 17.09.0+
3.3	            	| 17.06.0+
3.2	            	| 17.04.0+

* createChannel脚本中的localhost或者其他域名如果不对需要对应正确的地址和域名

* 步骤

0. 创建swarm网络fabric_network，添加节点，给节点打label
```
docker network create --driver overlay --attachable fabric_network
```
1. 生成证书和block（genCertAndChannel.sh）
2. 启动网络（start_cluster.sh）
3. 修改createChannel.sh并执行
4. 执行start_cluster.sh
5. docker stack deploy -c ./cli-docker.yaml hyperledger

* 区块浏览器

1. 配置./conig.json文件
2. 配置网络json文件：./connection-profile/
3. docker stack deploy -c ./explorer-docker.yaml hyperledger

* local测试

1. cd localtest
2. ./genCertAndChannel.sh
3. ./start_cluster.sh
4. docker stack deploy -c ./cli-docker.yaml hyperledger
5. docker stack deploy -c ./explorer-docker.yaml hyperledger
9. ./clean.sh

* rest api

1. http://localhost:8080/api-docs/#/  区块链浏览器封装了查询的api接口
2. restapi目录下封装了简单的chaincode调用接口，可以执行docker build创建镜像后通过根目录的restapi-docker.yaml启动api容器

* fabric cell

> doing...