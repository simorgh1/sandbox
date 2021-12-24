# Running Pi-hole with docker toolbox

[Pi-hole](https://pi-hole.net/) can be used in RaspberryPi, but it might be used in docker environment as well. I am using it for testing and later I prefer the RaspberryPi configuration.

## What is Pi-hole

Pi-hole is an ad blocker, it serves as the DNS server and blocks all domains from its blacklist by sending a blank as response.

## Setup

*I am using [docker toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) in Windows 10 home.*

Please update the run-pihole script and use your TZ and WEBPASSWORD env variables.

Start the default docker-machine if not already started

```powershell
PS C:\Pi-hole> docker-machine start default
```

Connect to the default machine and make the run-pihole script executeable, after that run the script:

```powershell
PS C:\Pi-hole> docker-machine ssh
docker@default:~$ chmod +x /c/pi-hole/run-pihole.sh
docker@default:~$ ./c/pi-hole/run-pihole.sh

```

You could run the script from windows, once it is executable:

```powershell
PS C:\Pi-hole> docker-machine ssh default /c/pi-hole/run-pihole.sh
```

## Dashboard

Open dashboard in your browser:

```powershell
PS C:\Pi-hole> start http://$(docker-machine ip default)/admin/
```

For the case you want to reset the password, please run the following command inside the container:

```powershell
PS C:\Pi-hole> docker exec -it pihole pihole -a -p
```

Browsing the web is faster with Pi-hole installation and using the dashboard, there are plenty of information for the current status, managing the black/white lists and long term statistics.

## Changing DNS settings

After installation, in Windows, open your network adapter settings and set the ip address of the Pi-hole as your new DNS server address. Do not set any secondary DNS server, it would make Pi-hole useless!

*Add DNS server address for all network adapters.*

For testing, run the following command:

```powershell
PS C:\Pi-hole> nslookup www.google.com
```

If your network adapter setting for DNS server is correct, you should have a valid response and Pi-hole ip address as the configured DNS server.
