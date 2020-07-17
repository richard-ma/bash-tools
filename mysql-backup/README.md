# mysql-backup.sh

## 安装
1. 解压后将mysql-backup.sh文件所在的目录记下来,后面称之为安装目录
1. 打开mysql-backup.sh文件进行编辑,配置运行参数
1. Local_Backup_Home_Dir为本地备份文件保存目录,此目录可任意选择,把目录路径填上
1. MYSQL_Dump为mysqldump命令位置,可以使用`which mysqldump`命令查看
    * 使用lnmp安装的位置一般是`/usr/local/mysql/bin/mysqldump`
1. Backup_Database为要备份的数据库名,多个数据库可以用空格隔开,例如:
    * `Backup_Database=("database1" "database2")`
1. MYSQL_UserName是MYSQL的用户名,一般用`root`
1. MYSQL_Password是MYSQL用户对应的密码
1. Backup_activate_days是备份要保留的天数
