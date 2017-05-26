# A Frontend Node JS docker image.

A Docker container for setting up node js client to the backend api.

This server serves requests from varnish container. This at the moment is best suited for development purposes.

This is a sample frontend node docker container used to test Wordpress installation on [http://globalfoodbook.com](http://globalfoodbook.com)


To build this frontend node js client server run the following command:

```bash
$ docker pull globalfoodbook/frontnode
```

This will run on a default port of 80.

To change the PORT for this run the following command:

```bash
$ docker run --name=frontnode --link swag:api --env GFB_API_KEYS=${GFB_API_KEYS} --env MAILCHIMP_API_KEY=${MAILCHIMP_API_KEY} --env MAILCHIMP_LIST_ID=${MAILCHIMP_LIST_ID} --env GFB_HTTP_BASIC_USER=${GFB_HTTP_BASIC_USER} --env GFB_HTTP_BASIC_PASS=${GFB_HTTP_BASIC_PASS} --env GFB_CDN_URL=${GFB_CDN_URL} --env GFB_API_BACKEND_URL=${GFB_API_BACKEND_URL}  --volume=/path/to/app/on/host:/path/to/app/on/container --detach=true
```

To run the server and expose it on port 80 of the host machine, run the following command:

```bash
$ docker run --name=frontnode --detach=true  --link swag:api --env GFB_API_KEYS=${GFB_API_KEYS} --env MAILCHIMP_API_KEY=${MAILCHIMP_API_KEY} --env MAILCHIMP_LIST_ID=${MAILCHIMP_LIST_ID} --env GFB_HTTP_BASIC_USER=${GFB_HTTP_BASIC_USER} --env GFB_HTTP_BASIC_PASS=${GFB_HTTP_BASIC_PASS} --env GFB_CDN_URL=${GFB_CDN_URL} --env GFB_API_BACKEND_URL=${GFB_API_BACKEND_URL}  --volume=/path/to/app/on/host:/path/to/app/on/container globalfoodbook/frontnode
```

To run the server in interactive mode of the host machine, run the following command:

```bash
$ docker run --name=frontnode -it  --link swag:api --env GFB_API_KEYS=${GFB_API_KEYS} --env MAILCHIMP_API_KEY=${MAILCHIMP_API_KEY} --env MAILCHIMP_LIST_ID=${MAILCHIMP_LIST_ID} --env GFB_HTTP_BASIC_USER=${GFB_HTTP_BASIC_USER} --env GFB_HTTP_BASIC_PASS=${GFB_HTTP_BASIC_PASS} --env GFB_CDN_URL=${GFB_CDN_URL} --env GFB_API_BACKEND_URL=${GFB_API_BACKEND_URL}  --volume=/path/to/app/on/host:/path/to/app/on/container globalfoodbook/frontnode /bin/bash
```

# NB:

## Before pushing to docker hub

## Login

```bash
$ docker login
```

## Build

```bash
$ cd /to/docker/directory/path/
$ docker build -t <username>/<repo>:latest .
```

## Push to docker hub

```bash
$ docker push <username>/<repo>:latest
```


IP=`docker inspect frontnode | grep -w "IPAddress" | awk '{ print $2 }' | head -n 1 | cut -d "," -f1 | sed "s/\"//g"`
HOST_IP=`/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

DOCKER_HOST_IP=`awk 'NR==1 {print $1}' /etc/hosts` # from inside a docker container

# Contributors

* [Ikenna N. Okpala](http://ikennaokpala.com)
