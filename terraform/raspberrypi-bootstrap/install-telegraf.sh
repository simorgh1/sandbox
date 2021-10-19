#!/bin/sh

# Installs telegraf if it is missing.
# configuration must be updated in order to submit the collected data.
if ! hash telegraf 2>/dev/null; then
    if [ ! -f /etc/apt/sources.list.d/influxdata.list ]; then        
        sudo echo 'deb [arch=armhf] https://repos.influxdata.com/debian buster stable' >> /etc/apt/sources.list.d/influxdata.list     
    fi
    
    sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
    sudo apt-get update -y
    sudo apt-get install -y telegraf
    sudo systemctl enable --now telegraf

    echo 'telegraf installation finished, update the configuration in /etc/telegraf/telegraf.conf'  
fi
