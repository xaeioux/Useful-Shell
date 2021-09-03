#!/bin/bash

crontab -u www-data -l > crontab
sed -i 's/ -c \/etc\/php\/7\.0\/apache2\/php\.ini//g' crontab > crontabs
echo ".................: Tarefas do Servidor :................"
cat crontabs
crontab -u www-data crontabs
rm crontab*
