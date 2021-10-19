$hosts = (docker ps --filter name=ansible_host -q)

foreach ($h in $hosts) {
    docker exec $h ./start-sshd.sh
}