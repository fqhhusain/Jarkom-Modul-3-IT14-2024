echo 'nameserver 192.240.4.3' > /etc/resolv.conf   # DNS Server 
apt-get update
apt-get install mariadb-server -y
service mysql start
