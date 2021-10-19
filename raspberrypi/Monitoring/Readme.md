# Monitoring Stack for RaspberryPi

Okay , My RaspberryPi 4 is up and running, docker and [portainer](https://www.portainer.io/) are installed, but next task is to monitor the system, specially metrics like CPU temprature, network and disk activities.

*Note*: I've used [raspberrypi-bootstrap](https://github.com/simorgh1/terraform) in order to install required docker and telegraf collector.

I will check first Grafana, InfluxDB and Telegraf as collector. Then I will import [RaspberryPi Monitoring Dashboard](https://grafana.com/grafana/dashboards/10578).

## Preparing system account for grafana

Telegraf and influxDb installation create the required system accounts for running this services but for grafana we have to create them before starting the monitoring stack.

Grafana is using a database in order to store it's settings and dashboards, in order to preserve them after container restart, we let grafana to persist its data in /var/lib/grafana folder.

### Step 1: Create a system account for grafana

```bash
#!/bin/bash
pi@raspberrypi:~ $ sudo useradd -r grafana -m -d /var/lib/grafana
```

This will add a system user with the name grafana and a group with the same name. In addition we let the home folder to be created. 

### Step 2: Changing the ownership of the home folder

Now we have to set the ownership of the folder.

```bash
#!/bin/bash
pi@raspberrypi:~ $ sudo chown -R grafana /var/lib/grafana
pi@raspberrypi:~ $ sudo chgrp -R grafana /var/lib/grafana
```

### Step 3: Select the user and group id for grafana

We will start grafana container using it's user and group id, let's select the ids

```bash
#!/bin/bash
pi@raspberrypi:~ $ id -u grafana
997
pi@raspberrypi:~ $ id -g grafana
992
```

grafana's user id is 997 and it's group id is 992 in my case, this might be different in your system. Now open docker-compose.yml and go to grafana service , where the user is specified and update the user property with the ids of your system.

After saving docker-compose file, all we need to do is to start the monitoring stack

```bash
#!/bin/bash
pi@raspberrypi:~ $ docker-compose up -d
```

The monitoring stack should be up and running, you could check it either in the portainer dashboard, stack menu, or just by asking docker ps ;-)

## Importing grafana monitoring Dashboard

First you have to open grafana, http://your-raspi-ip:3000/, the initail user/password is admin, then goto Configuration section and add influxdb datasource. It's address should be http://influxdb:8086/ and set the database name you [configured in telegraf](https://docs.influxdata.com/telegraf/v1.13/administration/configuration/) as influxdb output.

Then goto Dashboards -> Manage menu and hit import, there you could enter the [Monitoring Dashboard Id for RaspberryPi](https://grafana.com/grafana/dashboards/10578), which is 10587. Then choose influxDb as the data source. If telegraf is already running, you should see metrics, you might select shorter refresh rates.

If after several minutes, the Dashboard remains empty, you could open influxdb admin ui (Chronograf) and check the current activity.

Chronograf is part of the monitoring stack, you can open it with http://your-raspi-ip:8888/
In the menu host List, you should see an already running telegraf entry for raspberrypi host.
