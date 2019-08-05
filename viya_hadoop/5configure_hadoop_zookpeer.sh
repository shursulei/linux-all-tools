###在viya01上进行
ansible cas-all -m copy -a "src=/datafs/viayshare/tmp/profile dest=/etc/ owner=root group=root mode=0644" -b
ansible cas-all -m shell -a "source /etc/profile"
##修改数据目录权限
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data;chmod -R 755 /app/hadoop/data"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data01;chmod -R 755 /app/hadoop/data01"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data02;chmod -R 755 /app/hadoop/data02"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data03;chmod -R 755 /app/hadoop/data03"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data04;chmod -R 755 /app/hadoop/data04"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data05;chmod -R 755 /app/hadoop/data05"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data06;chmod -R 755 /app/hadoop/data06"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data07;chmod -R 755 /app/hadoop/data07"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data08;chmod -R 755 /app/hadoop/data08"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data09;chmod -R 755 /app/hadoop/data09"
ansible cas-all -m shell -a "chown -R hadoop:sas /app/hadoop/data10;chmod -R 755 /app/hadoop/data10"

ansible cas-all -m shell -a "chown -R hadoop:sas /opt/hadoop/*"

##配置zookpeer
###创建zookpeer的data目录
ansible cas-all -m shell -a "rm -rf /app/hadoop/zookpeer;mkdir -p /app/hadoop/zookpeer;chown -R hadoop:sas /app/hadoop/zookpeer"
##修改zookpeer的文件
ansible zk-all -b -m shell -a "chown -R hadoop:sas /opt/hadoop/zookeer-3.4.12"

##启动zookpeer
ansible cas01 -m shell -a "echo '1'>/app/hadoop/zookpeer/myid;chown hadoop:sas /app/hadoop/zookpeer/myid;"
ansible cas02 -m shell -a "echo '2'>/app/hadoop/zookpeer/myid;chown hadoop:sas /app/hadoop/zookpeer/myid;"
ansible cas03 -m shell -a "echo '3'>/app/hadoop/zookpeer/myid;chown hadoop:sas /app/hadoop/zookpeer/myid;"



##启动zookpeer
echo "======启动zookpeer===需要验证"
ansible zk-all -m shell -a "/opt/hadoop/zookpeer-3.4.12/bin/zkServer.sh start"

sleep 20s

##此处的journalnodes需要配置
ansible journalnodes -m shell -a "su hadoop;cd /opt/hadoop/hadoop-2.4.0/sbin;hadoop-daemon.sh start journalnode"