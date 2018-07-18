#!/bin/bash
curl -O https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo -o /etc/yum.repos.d/librehat-shadowsocks-epel-7.repo
yum install -y shadowsocks-libev
