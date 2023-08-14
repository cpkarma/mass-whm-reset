#! /bin/bash

# Avoid cPanel warnings
ALLOW_PASSWORD_CHANGE=1
export ALLOW_PASSWORD_CHANGE=1

# List all users and set random strong passwords
ls -1 /var/cpanel/users | while read user; do
pass=`strings /dev/urandom | tr -dc .~?_A-Z-a-z-0-9 | head -c16 | xargs`
echo "$user $pass" >> karma-user.txt

# Change the password & update FTP login database
/scripts/ftpupdate
/scripts/realchpass $user $pass

done
