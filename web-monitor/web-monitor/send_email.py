import smtplib

smtp_servers = {
        'gmail': {
            'server': 'smtp.gmail.com',
            'port': 587,
        },
        'qq': {
            'server': 'smtp.qq.com',
            'port': 587,
        },
}

def mail_send(email,password,subject_c, body_c, mail_to, smtp_server):
    with smtplib.SMTP(smtp_server['server'], smtp_server['port']) as smtp:
        smtp.ehlo()
        smtp.starttls()
        smtp.ehlo()

        smtp.login(email,password)

        subject = subject_c
        body = body_c

        message = f'From: {email}\r\nSubject: {subject} \r\n\r\n{body}'

        smtp.sendmail(email, mail_to, message)
