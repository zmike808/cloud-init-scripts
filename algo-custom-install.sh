#!/usr/bin/env sh

curl -s https://raw.githubusercontent.com/trailofbits/algo/master/install.sh | sudo -E bash -x

iptables -t mangle -A FORWARD --match policy --pol ipsec --dir in -s 10.10.10.10/24 -o eth0 -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
iptables -t mangle -A FORWARD -m policy --pol ipsec --dir in -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
iptables -t mangle -A FORWARD -m policy --pol ipsec --dir out -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
awesomesauce=net.ipv4.ip_no_pmtu_disc=1
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr"

echo "$awesomesauce" >> /etc/sysctl.conf

expermentalsauce="net.ipv4.tcp_fastopen=3
net.core.netdev_max_backlog = 65535
net.core.optmem_max = 65536
net.core.somaxconn = 65535
net.core.rmem_default = 33554432
net.core.wmem_default = 33554432
net.core.rmem_max = 33554432
net.core.wmem_max = 33554432
net.ipv4.tcp_rmem = 4096 12582912 33554432
net.ipv4.tcp_wmem = 4096 12582912 33554432
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_max_tw_buckets = 1048576
net.ipv4.tcp_no_metrics_save = 0
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_tw_reuse = 1"

echo "$expermentalsauce" >> /etc/sysctl.conf
