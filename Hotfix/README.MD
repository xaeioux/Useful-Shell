FixCrontab.sh

Reads the content of the user www-data and redirect into a file where it try to match /etc/php/7.0/apache2/php.ini and overwrite it with nothing.

PermissionFix.sh

Redo all the permissions in /var/log and if there is no matches for specific file/directory the script create it and apply the correct permission based on certain ERP

SslChecker.sh

Reads a file containing a domain in the format https://domain.com/ and test if the domain has an active SSL, then it prints the state into the screen also send a mail using msmtp to a specified destination.

NOTE: you'll have to install and configure the mail sender using a valid SMTP integration.

TmpClean.sh

Remove undesired files in /tmp that are filling the disk in a specific server. 
