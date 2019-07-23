# gitbox

**WARNING: DO NOT push dockerfile to dockerhub.**

## Howto

1. Init sshkey.

```
ssh-keygen -f idrsa -N ''
```

2. Build docker.

```
sudo docker build -t local/gitbox .
```

3. Edit docker-compose.yml.

* Change `LOCAL_USER_ID` to uid of your own user which showed by `id -u $USER`.
* Change `LOCAL_VOLUME` to the local directory which you want to map to the docker.

4. Run git command under `/project` in docker.

## Volumn permission in docker

Gosu is used to get the same permisson outside docker. So you can edit any files in `/project` and local user can have all the permission.

`entrypoint.sh` will auto create a new user with same uid of local user, and start `bash` with this user.

## Privacy suggestion and concern

1. **DO NOT** push ssh key to github.
2. `LOCAL_VOLUME` in `docker-compose.yml` may leak your own path.
3. `LOCAL_USER_ID` may leak your uid.

## TODO

* Reclace shell with zsh.

## Links

[Install gosu in docker from alpine](https://github.com/tianon/gosu/blob/master/INSTALL.md#from-alpine-37)

[解决 Docker 数据卷挂载的文件权限问题](https://padeoe.com/docker-volume-file-permission-problem/)
