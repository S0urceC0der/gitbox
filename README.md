# gitbox

**WARNING: DO NOT push dockerfile to dockerhub.**

Build a docker with a seperate git environment in order to avoiding privacy leak or account isolation.

## Howto

1. Init sshkey.

```
ssh-keygen -f idrsa -N ''
```

Add idrsa.pub to Github or Gitcafe.

2. Build docker.

```
sudo docker build -t local/gitbox .
```

3. Edit docker-compose.yml.

* Change `LOCAL_USER_ID` to uid of your own user which showed by `id -u $USER`.
* Change `GIT_NAME` to your git username.
* Change `GIT_EMAIL` to your git email.
* Change `LOCAL_VOLUME` to the local directory which you want to map to the docker.

4. Run git command under `/project` in docker.

## Volumn permission in docker

By default, docker write with root permission to the mapped volumn outside the docker. Here We use Gosu to change the user permission to the same permisson outside docker. So you can read/write any files in `/project` and local user can have all the permission.

`entrypoint.sh` will auto create a new user with same uid of local user, and start `bash` with this user.

Details can be found in reference [1] and [2].

## Privacy suggestion and concern

1. **DO NOT** push ssh key to github.
2. `LOCAL_VOLUME` in `docker-compose.yml` may leak your own path.
3. `LOCAL_USER_ID` may leak your uid.

## TODO

* Reclace bash shell with zsh.

## Reference

1. [Install gosu in docker from alpine](https://github.com/tianon/gosu/blob/master/INSTALL.md#from-alpine-37)

2. [解决 Docker 数据卷挂载的文件权限问题](https://padeoe.com/docker-volume-file-permission-problem/)
