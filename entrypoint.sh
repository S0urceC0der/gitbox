#!/bin/sh

# get uid
USER_ID=${LOCAL_USER_ID:-9001}
# add user with same uid
adduser -s /bin/bash -u $USER_ID -D user
addgroup user root
chown -R user:user /home/user
export HOME=/home/user
exec /usr/local/bin/gosu user "$@"
