#! /bin/bash

ret=$(rpm -qa containerd.io)
if [ ! -z $ret ] ;then
   echo "docker already exists!"
   exit
fi

exit
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
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

#安装新版本docker
yum install docker-ce docker-ce-cli containerd.io -y

#配置阿里云镜像
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://vvew714u.mirror.aliyuncs.com"]
}
EOF

#设置服务自启动
systemctl enable docker
systemctl start docker
