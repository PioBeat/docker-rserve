# README

This docker image uses openjdk as base image. Rserve will be compiled from scratch.
A user called ``ruser`` is created with a home directory and some start/kill scripts for Rserve.

**Notice: Access Docker from remote host**

For development you can access Docker from a remote host by executing the following commands (unsecure!):
```
sudo service docker stop
sudo dockerd -H tcp://192.168.1.102:2375 -H unix:///var/run/docker.sock &
sudo docker info
```
Replace the IP with your host IP.

## Configure Rserve

See files within the ``/etc/`` directory to set a password for the ``ruser``.

## Creating Container

First, pull the repository and execute the following commands:
``
cd docker-rserve
sudo docker build -t dgrzelak-rserve:v1 --add-host=localhost:192.168.1.102 -f Dockerfile .
``

After that, the container can be created and started:

```
sudo docker create -t -p 192.168.1.102:6311:6311 --name dgrzelak-rserve $(sudo docker images | awk '$1 ~ /dgrzelak-rserve/ { print $3}')
sudo docker start dgrzelak-rserve
```

The first port denotes the host port, and the second one represents the container port.

To create and start the container in one step:
```
sudo docker run -t -d -p 192.168.1.102:6311:6311 --name dgrzelak-rserve $(sudo docker images | awk '$1 ~ /dgrzelak-rserve/ { print $3}')
```

## Start/Stop Container

- Start: ``docker start dgrzelak-rserve``
- Restart: ``docker restart dgrzelak-rserve``
- Pause: ``docker pause dgrzelak-rserve``
- Stop: ``docker stop dgrzelak-rserve``

## Access Container

``docker exec -it dgrzelak-rserve bash``
