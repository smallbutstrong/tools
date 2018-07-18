#!/bin/bash
version=`rpm -q centos-release | cut -d- -f 3`
printf "install repo for shadowsocks..."
sudo wget -v https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-$version/librehat-shadowsocks-epel-$version.repo -o /etc/yum.repos.d/librehat-shadowsocks-epel.repo
printf "finished\n"
#yum install -y shadowsocks-libev
