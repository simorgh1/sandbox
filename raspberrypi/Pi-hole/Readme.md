## Pi-hole

[Pi-hole](https://pi-hole.net/) is an application for blocking ads, desinged for RaspberryPi. The goal here is to use it as the central ad blocker in the home network and all devices can enjoy the internet ad free and faster ;-)

After installation, either you could add the DNS Servers in your router to use the RaspberryPi, then no other changes on any other devices are required, or you change the DNS Settings on the device you want to restrict the ad blocking only.

### Installation

For RaspberryPi setup and configuring ssh and wifi auto configuration, please read [this page](../Setup/Readme.md) first.

I am going to install the Pi-hole as a docker container, but if you want to install it in your RaspberryPi, you could run the setup script provided by Pi-hole install page:

```
PS C:\> ssh pi@raspberrypi
pi@raspberrypi:~ $ curl -sSL https://install.pi-hole.net | bash
```

### Docker Setup
First install docker, if you already have it, skip this part:

```
pi@raspberrypi:~ $ curl -fsSL https://get.docker.com | bash
```

Then add pi user to the docker group in order to be able to use docker commands as a non root user:

```
pi@raspberrypi:~ $ sudo usermod -aG docker
```

### Run Pi-hole  in docker container
First download the run script:

```
pi@raspberrypi:~ $ curl -sSL https://raw.githubusercontent.com/pi-hole/docker-pi-hole/master/docker_run.sh -o docker_run.sh
```

Then update the TZ and set your default password in the environment variables:

```
    -e TZ="Your country/Your TZ City" \ 
    -e WEBPASSWORD="your strong password" \
```

Then create the folder structure where the Pi-hole configurations are stored

```
pi@raspberrypi:~ $ mkdir pihole
pi@raspberrypi:~ $ cd pihole
pi@raspberrypi:~ $ mkdir etc-pihole
pi@raspberrypi:~ $ mkdir etc-dnsmasq.d
```
After that start the container:

```
pi@raspberrypi:~ $ ./docker_run.sh
```

Now, it should be started, the output shows the current state of the container, you could check the status with the following command as well:

```
pi@raspberrypi:~ $ docker ps -l
```

Now, you have to configure your router to use the new DNS Server, just check the IP address of the RaspberryPi in the connected devices list in the router, and set this IP address as th new DNS Server.

### Backup

I recommend to backup the pi-hole folders periodicaly. You could create a cron job to copy all contents of the pihole folder, namely: etc-pihole and etc-dnsmasq.d

I have attached a USB drive and backup using the following command:

```
pi@raspberrypi:~ $ sudo cp --parents -r -f pihole/ /mnt/usblxr/
```

You could add the above command into a shell script and schedule it to run daily.
Add your backup shell into the cron with the following command:

```
pi@raspberrypi:~ $ crontab -e
```

Then add:

```
0 0 1 * * /home/pi/backup.sh
```

In order to backup everyday at 24:00
