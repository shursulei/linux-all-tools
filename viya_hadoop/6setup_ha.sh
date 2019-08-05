##登录namenode
namenode1=192.168.145.101
namenode2=192.168.145.102
scp_file=/opt/hadoop/hadoop-name/current/
server_dir=/opt/hadoop/hadoop-name/
su hadoop<<EOF1
hdfs namenode -format;
sleep 50s;
exit;
EOF1
/usr/bin/expect<<EOF
spawn scp -p $scp_file hadoop@$namenode2:$server_dir
expect{
    "passphrase"
    { 
      send "$server_pswd\n"; 
    } 
    "password"
    { 
       send "$server_pswd\n"; 
    } 
    "yes/no"
    { 
       send "yes\n"; 
       exp_continue; 
    } 
}
expect eof
EOF
echo "===开始启动hadoop========"
su hadoop<<EOF2
hdfs zkfc -format;
sleep 40s;
/opt/hadoop/hadoop-2.4.0/sbin/start-dfs.sh
exit;
EOF2

echo "=====启动结束==============="