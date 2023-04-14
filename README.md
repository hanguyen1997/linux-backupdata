# Linux--backupdata

[Linux] Backup data linux

-  login database
		sudo mysql or  mysql -u root -p
    
- Create user backup
		GRANT LOCK TABLES, SELECT ON DATABASE_NAME.* TO ‘NAME’_USER@‘localhost' IDENTIFIED BY ‘PASSWORD’;
		FLUSH PRIVILEGES;

- Create folder backup data
		cd ~
		mkdir Database_Backup 
    
- Create scripts backup
		touch db_backup.sh
		nano db_backup.sh
		sudo chmod 700 db_backup.sh
    
- Create file log 
		touch db_backup.log
		sudo chmod 700 db_backup.log
    
- Create cron job backup
		crontab -e
		11 00 * * * /home/db_backup.sh  (At 00:11)
