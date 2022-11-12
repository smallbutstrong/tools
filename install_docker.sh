#! /bin/bash

IS_INCHINA=1
ret=$(curl -s ipinfo.io)
if [[ ! $ret =~ .*"CN".* ]] ;then
   IS_INCHINA=0
fi

ret=$(rpm -qa containerd.io)
if [ ! -z $ret ] ;then
   echo "docker already exists!"
   #exit
fi

#移除旧的版本
yum remove docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-engine

#安装docker仓库
yum install -y yum-utils 
if [ $IS_INCHINA -eq 1 ] ; then
   yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
else
   yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
fi

#安装新版本docker
yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

#配置阿里云镜像
if [ $IS_INCHINA -eq 1 ] ; then
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://vvew714u.mirror.aliyuncs.com"]
}
EOF
fi



#设置服务自启动
systemctl enable docker
systemctl start docker
