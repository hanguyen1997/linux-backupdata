#!/bin/bash

# Configuration
backupfolder=Database_Backup # Directory to store backup files
logfile=db_backup.log # Log file
user=USER_BACKUP # MySQL user
password=password # MySQL password
keep_day=15 # Number of days to keep backup files
sqlfile=$backupfolder/all-database-$(date +%Y-%m-%d_%H-%M-%S).sql
zipfile=$backupfolder/all-database-$(date +%Y-%m-%d_%H-%M-%S).zip
echo Starting Backup [$(date +%Y-%m-%d_%H-%M-%S)] >> $logfile

# Backup
/usr/bin/mysqldump -u$user -p$password --all-databases >> $sqlfile
if [ $? == 0 ]; then
  echo 'Sql dump created' >> $logfile
else
  echo [error] mysqldump return non-zero code $? >> $logfile
  exit
fi

# Compress backup
zip -j $zipfile $sqlfile
if [ $? == 0 ]; then
  echo 'The backup was successfully compressed' >> $logfile
else
  echo '[error] Error compressing backup' >> $logfile
  exit
fi
rm $sqlfile
echo $zipfile >> $logfile
echo Backup complete [$(date +%Y-%m-%d_%H-%M-%S)] >> $logfile

# Delete old backups
find $backupfolder -mtime +$keep_day -delete
