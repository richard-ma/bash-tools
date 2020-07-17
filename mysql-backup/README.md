# mysql-backup.sh

## 一些约定
1. 服务器A上有运行的cscart网站需要备份,备份后的数据库需要再上传到服务器B,后面服务器A称为web服务器,服务器B称为备份服务器

## 备份服务器配置

### 安装FTP服务端
1. 使用lnmp提供的脚本安装Pure-FTP软件
1. 进入到lnmp解压压缩包后生成的目录中,找到`pureftpd.sh`文件
1. 运行这个脚本`./pureftpd.sh`,按回车确认后开始安装(安装过程可能需要几分种)

### 创建一个保存上传文件的目录
1. 使用mkdir命令创建一个保存上传文件的目录
    * 我一般会使用/home/ftp这个目录,创建命令为`mkdir -p /home/ftp`
1. 记下这个目录的路径,后面称为ftp根目录

### 添加ftp用户
1. 运行`lnmp ftp add`命令来添加ftp的用户
1. 按照自己意愿创建一个ftp用户名(我一般习惯使用ftp)
1. 按照自己意愿创建一个用户名对应的密码
1. 填写ftp根目录路径,就是上面创建的那个目录的路径

## Web服务器配置

### 安装脚本
1. 解压后将mysql-backup.sh文件所在的目录记下来,后面称之为安装目录
1. 打开mysql-backup.sh文件进行编辑,配置运行参数

### 备份配置
1. Backup_Home为本地备份文件保存目录,此目录可任意选择,把目录路径填上
1. MYSQL_Dump为mysqldump命令位置,可以使用`which mysqldump`命令查看
    * 使用lnmp安装的位置一般是`/usr/local/mysql/bin/mysqldump`
1. Backup_Database为要备份的数据库名,多个数据库可以用空格隔开,例如:
    * `Backup_Database=("database1" "database2")`
1. MYSQL_UserName是MYSQL的用户名,一般用`root`
1. MYSQL_Password是MYSQL用户对应的密码
1. Backup_activate_days是备份要保留的天数

### ftp上传配置
1. Enable_FTP=0 0为打开上传,1为关闭上传
1. FTP_Host为备份服务器的IP地址
1. FTP_Username为前面在备份服务器上创建的ftp用户
1. FTP_Password为ftp用户对应的密码
1. FTP_Dir为保存文件的目录,如果留空则直接保存在ftp根目录中

### 测试运行
1. 配置完成后可以测试运行`./mysql-backup.sh`
1. 检查Web服务器上Backup_Home目录中是否有生成sql结尾的备份文件
1. 如果开启了ftp上传,则需要检查备份服务器上对应目录中sql备份文件是否已上传

### 说明
1. 由于ftp配置和网络环境差异性非常大,本文档无法覆盖所有可能出现的情况,遇到问题清联系我或先行查看下面的Trouble Shooting章节.
1. 本文档会根据遇到的问题进行修订,使用时请确认文档和脚本代码都是最新的,且版本一致

## Trouble Shooting
