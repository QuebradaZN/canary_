#!/bin/bash

path="$HOME/db-backups"
mysqlUser="tibia"
mysqlPass="ohBYC@pmQrLtt4XR3MjM"
mysqlDatabase="tibia"


# Don't move from here
TIMER="$(date +'%d-%m-%Y-%H-%M')"
mkdir -p "$path"

if [[ -z "$mysqlUser" || -z "$mysqlPass" || -z "$mysqlDatabase" ]]; then
    echo "Please fill in username, password and database in settings."
else
    mysqldump -u$mysqlUser -p$mysqlPass $mysqlDatabase > "$path""/""$mysqlDatabase""-""$TIMER"".sql"
    echo "Backup Complete."
fi
