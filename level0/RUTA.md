# LEVEL 0
## Suave

Desensamblamos main, vemos una llamada a atoi con el primer argumento del programa, y compara el retorno con el valor `0x1a7`,
si retorna el mismo valor sigue su flujo de trabajo esperado.

```bash
level0@RainFall:~$ ./level0 423
$ whoami
level1
```

Leemos la pass en el $HOME del nuevo usuario.
```bash
level1@RainFall:/home/user/level1$ cat .pass
1fe8a524fa4bec01ca4ea2a869af2a02260d4a7d5fe7e7c24d8617e6dca12d3a
```