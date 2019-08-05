sashadoop_home=/opt/hadoop/sashadoop
cd /opt/hadoop;
tar zxvf sashadoop.tar.gz;
sleep 10s;
cd $sashadoop_home;
chmod -R +x *;
/usr/bin/expect<<EOF
spawn $sashadoop_home/hadoopInstall
expect "(1/2/3/4)?"
send "1\r"
expect "Enter path to Hadoop"
send "/opt/hadoop\r"
expect "Do you wish to use"
send "N\r"
expect eof
EOF

echo "=====配置环境变量===="
cat>/etc/profile<EOF
export HADOOP_HOME=/opt/hadoop/hadoop-2.4.0
export LD_LIBRARY_PATH=\$HADOOP_HOME/bin:\$LD_LIBRARY_PATH
export PATH=\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:\$PATH
EOF
echo "=====将环境变量文件拷贝到共享目录中"
cp /etc/profile /datafs/viayshare/tmp/

	##追加hdfs-site.xml文件
	sed -i "/<configuration>/a\\\t\<property\>\n\\t\\t\<name\>dfs.webhdfs.enabled\</name\>\n\\t\\t\<value\>true\</value\>\n\\t\</property\>"   ${ROOT_HOME}/etc/hadoop/hdfs-site.xml
    sed -i "/<configuration>/a\\\t\<property\>\n\\t\\t\<name\>dfs.replication\</name\>\n\\t\\t\<value\>2\</value\>\n\\t\</property\>"   ${ROOT_HOME}/etc/hadoop/hdfs-site.xml
    sed -i "/<configuration>/a\\\t\<property\>\n\\t\\t\<name\>dfs.datanode.data.dir\</name\>\n\\t\\t\<value\>file:${hadoop_name}\</value\>\n\\t\</property\>"   ${ROOT_HOME}/etc/hadoop/hdfs-site.xml
    sed -i "/<configuration>/a\\\t\<property\>\n\\t\\t\<name\>dfs.namenode.name.dir\</name\>\n\\t\\t\<value\>file:${hadoop_data}\</value\>\n\\t\</property\>"   ${ROOT_HOME}/etc/hadoop/hdfs-site.xml
    sed -i "/<configuration>/a\\\t\<property\>\n\\t\\t\<name\>dfs.namenode.secondary.http-address\</name\>\n\\t\\t\<value\>master:9001\</value\>\n\\t\</property\>"   ${ROOT_HOME}/etc/hadoop/hdfs-site.xml
	##修改core-site.xml文件
	sed -i "/<configuration>/a\\\t\<property\>\n\\t\\t\<name\>fs.defaultFS\<\/name\>\n\\t\\t\<value\>hdfs://${NAMENODE}:9000\<\/value\>\n\\t\<\/property\>\n\\t\<property\>\n\\t\\t\<name\>hadoop.tmp.dir\<\/name\>\n\\t\\t\<value\>file:$(echo ${hadoop_tmp})\<\/value\>\n\\t\</property\>"  ${ROOT_HOME}/etc/hadoop/core-site.xml
	##拷贝hadoop文件到另一个namenode
	cd /opt/hadoop
	for hst in $(cat /datafs/viayshare/cashosts);do scp -r hadoop-2.4.0/ $hst:/opt/hadoop/;done
	for hst in $(cat /datafs/viayshare/cashosts);do scp -r hadoop-name/ $hst:/opt/hadoop/;done