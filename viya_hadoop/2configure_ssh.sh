####登录到namenode上，使用root登录shell
####cashosts文件为所有的hdfs机器内容
echo "登录到namenode，并且使用hadoop用户登录"
echo "=========================================="
echo "开始为hadoop用户配置免密钥"
su hadoop<<EOF1
ssh-keygen -q -t rsa -N ''-f ~/.ssh/id_rsa;
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys;
chmod 600 ~/.ssh/authorized_keys;
for hst in $(cat /datafs/share/cashosts);do scp -pr ~/.ssh $hst:~;done;
echo "===验证hadoop是否创建成功===="
for hst in $(cat /datafs/share/cashosts);do ssh $hst "hostname;id hadoop";done;
exit;
EOF1
su hdfs<<EOF2
ssh-keygen -q -t rsa -N ''-f ~/.ssh/id_rsa
chmod 600 ~/.ssh/authorized_keys;
for hst in $(cat /datafs/share/cashosts);
do scp -pr ~/.ssh $hst:~;done;
echo "=============验证hdfs用户是否创建成功===="
for hst in $(cat /datafs/share/cashosts);
do ssh $hst "hostname;id hdfs";done;
exit;
EOF2

echo "==创建sashadoop配置需要用的datahosts文件====="
cat>/opt/hadoop/hadoophosts<<EOF
linux-109129
linux-109130
linux-109131
EOF