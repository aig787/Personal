#!/usr/bin/python3
import subprocess, platform, fnmatch, os, time

def linux_search(root, pattern):
    matches = []
    for root, dirs, files, in os.walk(root):
        for filename in fnmatch.filter(files, pattern):
            matches.append(os.path.join(root, filename))
    return matches

def get_owners(matches):
    owners = []
    for match in matches:
        file = open(match, 'r')
        owner = file.read().strip()
        if owner and not owner.isspace():
            owners.append(owner)
    return owners

def run_check():
    status = []
    if system == 'Linux':
        output = str(subprocess.check_output(['ps', '-A']))
        if 'httpd' in output:
            print("Httpd is running!")
            status.append(('httpd', 'on'))
        else:
            print("Httpd is down...")
            status.append(('httpd', 'off'))
        if 'sshd' in output:
            print("SSH is running!")
            status.append(('ssh', 'on'))
        else:
            print("SSH is down...")
            status.append(('ssh', 'off'))
        owners = []
        owners.extend(get_owners(linux_search('/home', 'ownership.txt')))
        return status,owners
    elif system == 'Windows':
        cmd = 'WMIC PROCESS get Caption,Commandline,Processid'
        proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        for line in proc.stdout:
            print(line)

system = platform.system()
print(system + ' system')

while True:
    status, owners = run_check()
    print(status)
    print(owners)
    time.sleep(30)

