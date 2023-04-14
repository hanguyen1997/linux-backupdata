#!/bin/bash

backupfolder=Database_Backup # Thư mục lưu trữ file backup
logfile=db_backup.log #ghi log ra file
# MySQL user
user=USER_BACKUP
# MySQL password
password=password
# Ngày giữ lại file backup
keep_day=15
sqlfile=$backupfolder/all-database-$(date +%Y-%m-%d_%H-%M-%S).sql
zipfile=$backupfolder/all-database-$(date +%Y-%m-%d_%H-%M-%S).zip
echo Starting Backup [$(date +%Y-%m-%d_%H-%M-%S)] >> $logfile

# Tạo một backup
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