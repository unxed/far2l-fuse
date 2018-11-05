# far2l-fuse

English version is below.

Очень простое дополнение к [far2l](https://github.com/elfmz/far2l). Обертка вокруг FUSE. Основана на коде [far-gvfs](https://github.com/cycleg/far-gvfs). На данный момент поддерживается только sshfs (URL вида "sftp://host.domain"). Альфа-версия, **использование на свой страх и риск!**

Запрос подтверждения при неизвестном идентификаторе хоста пока не сделан, так что подключиться получится только к тем хостам, к которым уже подключались любым клиентом, обновляющим ~/.ssh/known_hosts (консольным ssh, например). 

---

Very simple [far2l](https://github.com/elfmz/far2l) plugin to ease FUSE remote mounts. Based on [far-gvfs](https://github.com/cycleg/far-gvfs). Only sshfs currently available with URLs like "sftp://host.domain". Alpha version, **use at your own risk!**

As host key verification dialog is not implemented yet, you need to connect to your host with `ssh hostname` before accessing it from far2l-fuse for the first time.
