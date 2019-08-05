##需要在viya01上运行，及拥有ansible的机器上运行
#给hdfs机器配置,cashosts为所有需要配置hosts的文件
ansible_working=/datafs/viya/working
namenode1=192.168.145.101
echo "==========================================="
echo "开始添加hadoop和hdfs,并设置密码,此处需要设置手动输入密码，此处的密码统一和PASSWORD变量相同"
cd $ansible_working
ansible cas-all -b -m shell "useradd hadoop -g sas -d /home/hadoop -m -u 1401"
ansible cas-all -b -m shell "useradd hdfs -g sas -d /home/hdfs -m -u 1402"
for hst in $(cat /datafs/viyashare/cashosts); do ssh $hst "echo 'viya@123' |passwd --stdin hadoop";done
for hst in $(cat /datafs/viyashare/cashosts); do ssh $hst "echo 'viya@123' |passwd --stdin hdfs";done
##此处验证一下各个用户
#
#
#

##创建hadoop文件并设置用户和用户组
ansible cas-all -b -m shell -a "mkdir -p /opt/hadoop;mv /opt/hadoop /opt/hadoop_bak;mkdir -p /opt/hadoop;chown hadoop:sas /opt/hadoop"
##准备sashadoop到namenode中,这个文件来源可以修改
scp -pr /datafs/depot/viya/sassupplement/hdfs/sashadoop.tar.gz $namenode1:/opt/hadoop