#!/usr/bin/python3
import subprocess, platform, fnmatch, os, time

# Search linux system starting at specified root location for file matching
# given pattern
def linux_search(root, pattern):
    matches = []
    for root, dirs, files, in os.walk(root):
        for filename in fnmatch.filter(files, pattern):
            matches.append(os.path.join(root, filename))
    return matches

# Strip name from each ownership.txt file listed in matches
# Return list of "owners"
def get_owners(matches):
    owners = []
    for match in matches:
        file = open(match, 'r')
        owner = file.read().strip()
        if owner and not owner.isspace():
            owners.append(owner)
    return owners

# Check for ownership.txt files and for running services
# Status list is packaged as tuples to send to the server
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
    # Lists running processes for now, but will have same functionality as Linux    case
    elif system == 'Windows':
        import wmi
        c = wmi.WMI()
        for process in c.Win32_Process:
            #Check processes here
            name = process.Name
            if name == "notepad.exe":
                print("Notepad is running!")
                status.append(('ssh', 'on'))

system = platform.system()
# List OS
print(system + ' system')

# Loop every 30 seconds
while True:
    status, owners = run_check()
    print(status)
    print(owners)
    time.sleep(30)

