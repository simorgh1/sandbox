#!/usr/bin/env bash

set -e

# https://github.com/pi-hole/docker-pi-hole/blob/master/README.md

function update_pihole
{
    printf 'Setting up pihole\n'
    if (docker inspect pihole > /dev/null &2>1);
    then
        docker stop pihole > /dev/null
        docker rm pihole > /dev/null
        docker rmi pihole/pihole:latest > /dev/null
    fi

    printf 'Pulling latest pihole image\n'
    docker pull pihole/pihole:latest > /dev/null

    printf 'Starting up pihole container '
    docker run -d \
        --name pihole \
        -p 53:53/tcp -p 53:53/udp \
        -p 80:80 \
        -p 443:443 \
        -e TZ="Germany/Berlin" \
        -e WEBPASSWORD="YOUR_PASSWORD" \
        -v "$(pwd)/etc-pihole/:/etc/pihole/" \
        -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
        --restart=unless-stopped \
        --network=host \
        --cap-add=NET_ADMIN \
        --cap-add=CAP_SYS_NICE \
        pihole/pihole:latest > /dev/null

    for i in $(seq 1 20); do
        if [ "$(docker inspect -f "{{.State.Health.Status}}" pihole)" == "healthy" ] ; then
            printf ' OK'
            echo -e "\nChecking dns server"
            nslookup www.google.com localhost
            exit 0
        else
            sleep 3
            printf '.'
        fi

        if [ $i -eq 20 ] ; then
            echo -e "\nTimed out waiting for Pi-hole start, consult check your container logs for more info (\`docker logs pihole\`)"
            exit 1
        fi
    done;
}

printf "Current DNS configuration\n\n"
cat /etc/resolv.conf

echo ""
read -e -p "Please ensure to configure a secondary dns server when restarting pihole, proceed? " choice
[[ "$choice" == [Yy]* ]] && update_pihole || exit -1
