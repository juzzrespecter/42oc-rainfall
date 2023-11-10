#/usr/bin/env python

import subprocess
import sys
from subprocess import CalledProcessError

if len(sys.argv) != 2:
    print >> sys.stderr, "./fuzz.py [binary to fuzz]"
    sys.exit(1)
exit_code = 0
i = 0
while exit_code != -11:
    i += 1
    payload = "A" * i
    pld = subprocess.Popen(('echo', payload), stdout=subprocess.PIPE)
    try:
        exit_code = subprocess.check_call([sys.argv[1]], stdin=pld.stdout)
    except CalledProcessError as e:
        exit_code = e.returncode
print("payload size: ", i)
