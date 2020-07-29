# web-monitor

## 用途
用于监控网站页面是否可以正常打开

## 系统需求
* Python 3.6及以上
* virtualenv
* pip

## 安装
1. 将压缩包解压到任意目录, 此目录后文称为工作目录
1. cd进入工作目录
1. 使用`virtualenv -p python3 venv`命令创建工作环境
1. 使用`source ./venv/bin/activate`命令使工作环境生效
1. 使用`pip install -r requirements.txt`命令安装依赖的python包

## 配置
1. 将需要检查的网址写入/web-monitor/checklist文件中(每行一个,以http://开头)
1. 打开/web-monitor/config文件,配置邮件服务器
    1. email为发邮件邮箱地址
    1. password为发邮件邮箱密码(少数邮箱发送邮件密码不同于登陆密码,请查看邮箱说明)
    1. mail_title为发送邮件的标题
    1. mail_to为邮件发送到的邮箱, 即服务器管理员要查看的邮箱
    1. mail_server发送邮件服务器,目前支持qq和gmail

## 测试运行
1. 使用`source ./venv/bin/activate`命令使工作环境生效
1. 在工作目录使用`python ./web-monitor/monitor.py`命令运行程序
