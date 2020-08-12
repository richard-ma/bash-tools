# web-monitor

## 用途
用于监控网站页面是否可以正常打开

## 系统需求
* Python 3.6及以上

## 安装
1. 将压缩包解压到任意目录, 此目录后文称为工作目录
1. cd进入工作目录
1. 使用`pip3 install -r requirements.txt`命令安装依赖的python包

## 配置
1. 将需要检查的网址写入checklist文件中(每行一个,以http://开头)
1. 打开config文件,配置邮件服务器
    1. email为发邮件邮箱地址
    1. password为发邮件邮箱密码(少数邮箱发送邮件密码不同于登陆密码,请查看邮箱说明)
    1. mail_title为发送邮件的标题
    1. mail_to为邮件发送到的邮箱, 即服务器管理员要查看的邮箱
    1. mail_server发送邮件服务器,目前支持qq和gmail

## 测试运行
1. 在工作目录使用`python3 monitor.py`命令运行程序
1. 运行结果
    1. 能看到每个网址的测试结果
    1. 如果有网址状态为Failed,则可以在邮箱收到通知邮件

## 定时执行(可选)
1. 使用`crontab -e`打开定时任务设定文件
1. 如需要在每天凌晨3点15分执行, 可使用如下的配置(monitor.py安装路径为/root/web-monitor/)
    * `15 3 * * * python3 /root/web-monitor/monitor.py`
    * 第一个数字代表定时的分钟, 第二个数字代表定时的小时, 可根据需要自行修改时间
    * `*/30 * * * * python3 /root/web-monitor/monitor.py`也可以用这种方法让脚本每30分钟执行一次

## 说明
1. 由于配置和网络环境差异性非常大,本文档无法覆盖所有可能出现的情况,遇到问题清联系我或先行查看下面的Trouble Shooting章节.
1. 本文档会根据遇到的问题进行修订,使用时请确认文档和脚本代码都是最新的,且版本一致

## Trouble Shooting
None
