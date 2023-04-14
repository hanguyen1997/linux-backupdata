# Linux-backupdata

## About
Daily automatic backup of MySQL database by cron job

## Prerequisites

Before you continue, ensure you meet the following requirements:

* You are using a Linux.

## Setup & start
#### 1. login database

```bash
sudo mysql
```
 or
```bash
mysql -u root -p
```

#### 2. Create user backup
```bash 
GRANT LOCK TABLES, SELECT ON DATABASE_NAME.* TO ‘NAME’_USER@‘localhost' IDENTIFIED BY ‘PASSWORD’;
FLUSH PRIVILEGES;
```

#### 3. Create folder backup data
```bash 
cd ~
mkdir Database_Backup 
```

#### 4. Create scripts backup
```bash
touch db_backup.sh
nano db_backup.sh
sudo chmod 700 db_backup.sh
```
    
#### 5. Create file log 
```bash
touch db_backup.log
sudo chmod 700 db_backup.log
```
    
### 6. Create cron job backup
(At 00:11 daily)
```bash
crontab -e
```
```bash
11 00 * * * /home/db_backup.sh
```
