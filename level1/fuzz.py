#/usr/bin/env python

import subprocess
from subprocess import CalledProcessError

exit_code = 0
i = 0
while exit_code != -11:
    i += 1
    payload = "A" * i
    pld = subprocess.Popen(('echo', payload), stdout=subprocess.PIPE)
    try:
        exit_code = subprocess.check_call(["./level1"], stdin=pld.stdout)
    except CalledProcessError as e:
        exit_code = e.returncode
print("payload size: ", i)