# far2l-fuse

English version is below.

Очень простое дополнение к [far2l](https://github.com/elfmz/far2l). Обертка вокруг FUSE. Основана на коде [far-gvfs](https://github.com/cycleg/far-gvfs). Альфа-версия, **использование на свой страх и риск!**

На данный момент поддерживается только sshfs (URL вида "sftp://host.domain"). Запрос подтверждения при неизвестном идентификаторе хоста пока не сделан, так что подключиться получится только к тем хостам, к которым уже подключались любым клиентом, обновляющим ~/.ssh/known_hosts (`ssh user@hostname.tlg` в консоли, например). 

---

Very simple [far2l](https://github.com/elfmz/far2l) plugin to ease FUSE remote mounts. Based on [far-gvfs](https://github.com/cycleg/far-gvfs). Alpha version, **use at your own risk!**

Only sshfs currently available with URLs like "sftp://host.domain". As host key verification dialog is not implemented yet, you need to connect to your host with `ssh user@hostname.tlg` before accessing it from far2l-fuse for the first time.
