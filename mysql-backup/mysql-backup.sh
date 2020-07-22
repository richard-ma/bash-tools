#!/usr/bin/env bash

# Backup mysql database use mysqldump tools
# Author: richard_ma (richard.ma.19850509@gmail.com)

###############################################################################
# Settings
###############################################################################

Backup_Home="/home/backup/" # 备份文件保存的目录
MySQL_Dump="/usr/local/mysql/bin/mysqldump" # mysqldump所在的目录
Backup_Database=("database1" "database2") # 要备份的数据库,多个数据库可以("database1" "database2"),用空格隔开
MYSQL_UserName='root' # mysql用户名
MYSQL_PassWord='your_password' # mysql用户名对应的密码
Backup_activate_days=10 #备份保留的天数

# FTP Settings
Enable_FTP=0 # 0: enable; 1: disable
FTP_Host='1.4.1.5' # FTP服务器IP地址
FTP_Username='ftp' # FTP服务器用户名
FTP_Password='ftp' # FTP服务器用户对应密码
FTP_Dir="" # FTP服务器目录, 空表示根目录

# Secondary FTP Settings
Enable_Secondary_FTP=0 # 0: enable; 1: disable
FTP_Secondary_Host='1.4.1.5' # FTP服务器IP地址
FTP_Secondary_Username='ftp' # FTP服务器用户名
FTP_Secondary_Password='ftp' # FTP服务器用户对应密码
FTP_Secondary_Dir="" # FTP服务器目录, 空表示根目录

###############################################################################
# Settings End
###############################################################################

TodayDBBackup=db-*-$(date +"%Y%m%d").sql
OldDBBackup=db-*-$(date -d -${Backup_activate_days}day +"%Y%m%d").sql

Backup_Sql()
{
    ${MySQL_Dump} -u$MYSQL_UserName -p$MYSQL_PassWord $1 > ${Backup_Home}db-$1-$(date +"%Y%m%d").sql
}

# Backup Database
echo "Backup Databases..."
for db in ${Backup_Database[@]};do
    Backup_Sql ${db}
done

# Delete old backup files
echo "Delete old backup files..."
rm -f ${Backup_Home}${OldDBBackup}

# Upload to FTP server
if [ ${Enable_FTP} = 0 ]; then
    echo "Uploading backup files to ftp..."
    cd ${Backup_Home}
    lftp ${FTP_Host} -u ${FTP_Username},${FTP_Password} << EOF
set ftp:use-feat no
set ftp:ssl-allow no
cd ${FTP_Dir}
mrm ${OldDBBackup}
mput ${Backup_Home}${TodayDBBackup}
bye
EOF

echo "Uploading backup files to ftp complete."
fi

# Upload to Secondary FTP server
if [ ${Enable_Secondary_FTP} = 0 ]; then
    echo "Uploading backup files to secondary ftp..."
    cd ${Backup_Home}
    lftp ${FTP_Secondary_Host} -u ${FTP_Secondary_Username},${FTP_Secondary_Password} << EOF
set ftp:use-feat no
set ftp:ssl-allow no
cd ${FTP_Secondary_Dir}
mrm ${OldDBBackup}
mput ${Backup_Home}${TodayDBBackup}
bye
EOF

echo "Uploading backup files to secondary ftp complete."
fi

