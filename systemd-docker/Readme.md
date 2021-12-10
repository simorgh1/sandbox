# Running systemd in docker

The latest version of Docker Desktop 4.3.0 was [released](https://docs.docker.com/desktop/mac/release-notes/#docker-desktop-430) on 2021-12-02 and it includes several upgrades
like Docker Engine, containerd, Buildx, Kubernetes etc but includes also some bug fixes and minor changes for example it uses cgroupv2 and how to use it to run systemd.

In this example I tried to find out how to use systemd in a container using docker.

## What is systemd?

[systemd](https://systemd.io) is a process manager which offers on-demand starting of daemons, so if you want to run a container and one or multiple services should run on startup, systemd should be started as the first process with PID 1 and it will start the rest of the system.

If you have a service that needs to be started by systemd, for example a maintenance job started on reboot/start which connects the current jenkins node to master or any other service which should run on startup, you need to write a [systemd service](https://linuxconfig.org/how-to-write-a-simple-systemd-service) and configure it.

## Hello world sample

hello world is a simple page served by httpd, so we need to install httpd and add our sample page to it, but most important is to start systemd as the first process.

Included Dockerfile is using centos 8.0 as base image. We add httpd and some health check for our service to monitor the service.

## Requirements

- [Docker desktop v4.3.0](https://docs.docker.com/desktop/mac/release-notes/#docker-desktop-430)

## Getting started

`hello-world.sh` starts and stops the sample hello world service, it builds the Dockerfile if it was missing or changed since last build, then starts the service:

```bash
systemd-docker/$ ./hello-world.sh
```

## Exploring the service

After startup, wait a couple of seconds and check the service status:

```bash
systemd-docker/$ docker ps

CONTAINER ID   IMAGE                                                   COMMAND        CREATED         STATUS                   PORTS                NAMES
4a5cfce6ce20   systemd-in-d:fff334ef935890eb437a503bb0f769d2c8d211ef   "/sbin/init"   7 minutes ago   Up 7 minutes (healthy)   0.0.0.0:80->80/tcp   hello-world
```

then you could check the container logs, which will show systemd startup logs:

```bash
systemd-docker/$ docker logs hello-world
```

Check if the service is running by opening `http://localhost` in your browser, it should show the `Hello World` message.

Now we could login inside the container and check our sample service.

```bash
systemd-docker/$ docker exec -it hello-world bash
```

We check then the service status by the following command:

```bash
systemd-docker/$ systemctl status httpd
```

It shows the following information:

- The loaded service file in this case `/usr/lib/systemd/system/httpd.service`
- Service activation status and uptime
- Main PID
- Service running status, total requests served, Idle/Busy workers etc
- Tasks
- Memory used
- CGroups information: The list of httpd processes for serving the requests. Docker uses cgroups to limit the system resources.

And finally the listing ends with the httpd logs.

## Cleanup

In order to stop the sample service run:

```bash
systemd-docker/$ ./hello-world.sh stop
```
