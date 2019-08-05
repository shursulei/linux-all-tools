#在namenode上操作root操作
#此处需要修改zookpeer
ZOOKEEPER_HOME=/opt/hadoop/zookeer-3.4.12
namenode1=192.168.145.102
scp  -pr xxxxxxx $namenode1:/opt/hadoop
cd /opt/hadoop;

tar zxvf zookpeer-3.4.12.tar.gz;
cat>$ZOOKEEPER_HOME/zkServer<<EOF
linux-109129
linux-109130
linux-109131
EOF
cp $ZOOKEEPER_HOME/conf/zoo_sample.cfg $ZOOKEEPER_HOME/conf/zoo.cfg
cd $ZOOKEEPER_HOME/conf/
sed '12s/\/tmp\/zookpeer/\/app\/hadoop\/zookpeer/g' zoo.cfg
sed '$a\server.1=linux-109129:2888:3888' zoo.cfg
sed '$a\server.2=linux-109130:2888:3888' zoo.cfg
sed '$a\server.3=linux-109131:2888:3888' zoo.cfg
for hst in $(cat $ZOOKEEPER_HOME/zkServer);do scp -r /opt/hadoop/zookpeer-3.4.12/ $hst:/opt/hadoop/;done