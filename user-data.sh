#!/bin/bash -v

#sudo mkdir /var/www/html/drupal/sites/default/files
sudo cp -R files /var/www/html/drupal/sites/default/
sudo cp settings.php /var/www/html/drupal/sites/default/settings.php

sudo chown -R apache:apache  /var/www/html/drupal
sudo setsebool httpd_can_network_connect_db on
sudo cp drupal.conf /etc/httpd/conf.d/drupal.conf
sudo chown -R apache:apache  /var/www/html/drupal

sudo systemctl restart httpd

mysql -u admin -h database-1.chcspcb1tbum.us-east-1.rds.amazonaws.com -pAdmin1234

CREATE DATABASE drupal CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'drupal'@'%' IDENTIFIED BY 'Admin1234';
GRANT ALL PRIVILEGES ON drupal.* TO 'drupal'@'%';
FLUSH PRIVILEGES;
QUIT

mysql -u admin -h database-1.chcspcb1tbum.us-east-1.rds.amazonaws.com -pAdmin1234 drupal < dump_file.sql

