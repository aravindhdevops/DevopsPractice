#!/bin/bash
sudo su -
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
echo "Hi aravivo" > /var/www/html/index.html