import requests
import configparser
from send_email import *

record_keys = ['url', 'checked', 'running_status', 'status_code', 'error']

def load_checklist(filename):
    with open(filename, 'r') as f:
        lines = []
        for line in f.readlines():
            lines.append(line.rstrip('\r\n'))

        return lines


def check_status(url, verbose=False):
    try:
        r = requests.get(url)
        if verbose == 'False' and r.status_code == 200:
            print("Servers are not down Every a-okay! ")
        elif verbose == 'True' and r.status_code == 200:
            print(r.headers)
        else:
            print(r.status_code)
            print("Seems like servers are down... send email?")
    except Exception as e:
        print('ERROR: '+ str(e) + '')


def check_checklist(checklist, verbose=False):
    ret = []
    with requests.Session() as s: # create session
        for url in checklist:
            record = {x: '' for x in record_keys}
            record['url'] = url
            try:
                r = s.get(url)
                record['status_code'] = r.status_code
                if r.status_code == 200:
                    record['running_status'] = True
                else:
                    record['running_status'] = False
                record['checked'] = True # update checked status
            except Exception as e:
                record['checked'] = False
                record['error'] = 'ERROR: '+ str(e) + ''
            ret.append(record)

    return ret


def generate_mail_contents(result):
    ret = []
    for r in result:
        if r['checked'] == False:
            ret.append(f"{r['url']}: Unchecked Msg: {r['error']}")
        else:
            if r['running_status'] == False:
                ret.append(f"{r['url']}: Failed Status_Code: {r['status_code']}")

    return '\r\n'.join(ret)


def load_config(filename):
    config = configparser.ConfigParser()
    config.read(filename)
    return config

def main():
    config_filename = 'config'
    checklist_filename = 'checklist'
    config = load_config(config_filename)
    checklist = load_checklist(checklist_filename)
    req = check_checklist(checklist, True)
    send_email(
            config.get('smtp', 'email'),
            config.get('smtp', 'password'),
            config.get('smtp', 'mail_title'),
            generate_mail_contents(req),
            config.get('smtp', 'mail_to'),
            config.get('smtp', 'mail_server'))


if __name__ == '__main__':
    main()
