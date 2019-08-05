# 批量免密授信脚本使用说明

## 脚本清单

请放置同一个目录下

* sshhosts    --IP地址列表
* keysetup.exp  --expect脚本
* keyauto.sh  --调用脚本

## 调用方法

1 将需要免密授信的服务器ip添加之sshhosts中

2 在需要通过免密连接其他服务器或者其他用户的用户下执行下面的命令

````
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa -q
````

3 执行keyauto.sh 

格式: keyauto.sh <remote_username> <remote_user_password>

参数1：远程用户名

参数2：远程用户的密码

示例: 

````
./keyauto.sh sascfg sas1234
````



## 注意事项

如果用户的uid=0，和root用户的uid冲突，可能会导致脚本异常。