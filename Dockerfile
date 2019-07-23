FROM alpine:latest

# use chinese mirror during build, if you are not in China, comment this line
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# install gosu
ENV GOSU_VERSION 1.11
RUN apk add --no-cache --virtual .gosu-deps gnupg openssl dpkg
RUN set -eux; \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
    # verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu; \
    apk del .gosu-deps

RUN apk add git bash openssh-client
RUN mkdir /project; mkdir -p /home/user/.ssh/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY id_rsa /home/user/.ssh/
WORKDIR /project
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
