# set the base image to Debian
# https://hub.docker.com/_/debian/
FROM debian:latest

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# environment variables
ENV NVM_DIR=/usr/local/nvm NODE_VERSION=7.10.0 MY_USER=gfb PORT=80 GFB_API_BACKEND_URL=http://localhost:4231/v1 PUBLIC_GFB_DOMAINS=globalfoodbook.com,www.globalfoodbook.com,localhost GFB_CDN_URL=gfb.global.ssl.fastly.net GFB_HTTP_BASIC_USER=user GFB_HTTP_BASIC_PASS=pass GFB_API_KEYS=api-keys MAILCHIMP_API_KEY=wew MAILCHIMP_LIST_ID=list-id
ENV APP_HOME=/home/$MY_USER/app NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

ADD install_nvm.sh /etc/install_nvm.sh
ADD entrypoint.sh /etc/entrypoint.sh

# update the repository sources list
# and install dependencies
# install nvm node and npm
RUN apt-get update \
    && apt-get install -y curl wget vim \
    && apt-get -y autoclean \
    && mkdir -p $APP_HOME \
    && /etc/install_nvm.sh \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

WORKDIR $APP_HOME

EXPOSE $PORT

# Setup the entrypoint
ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["/etc/entrypoint.sh"]
