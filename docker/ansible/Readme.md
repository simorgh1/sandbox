## Ansible in docker

Ansible is an open-source software provisioning, configuration management, and application-deployment tool.

If you have a Windows environment and want to learn or test ansible, you need a Linux environment, since there is no Windows version available as of now.

The Ansible could be of course installed in WSL Ubuntu, but how about an environment, where there is a controller, which is the machine with ansible installed, and some hosts where ansible is going to run playbooks, and there are all in the same network and the container names are resolvable by the controller?

This is exactly what the following docker-compose is doing, it creats the ansible controller container and host containers which are all based on ubuntu 18.04 and runs them in the same network.

It means all containers are resolved by theire names, for example
controller container will be ansible_controller and the host containers whill be ansible_host_1. The host container could be scalled up using docker-compose.

All components required in the containers for running ansible playbooks are pre-installed, there are some configurations that needs to be done manually.

### Prepare the environment
You need docker be installed, if you have Windows 10 home edition, then please install docker toolbox.

### Running the ansible containers

If you made any changes to the docker files, use the build compose file:

```
 PS C:\Source\ansible\> docker-compose -f .\docker-compose-build.yml up
```

Otherwise just start the containers using docker hub images:

```
PS C:\Source\ansible\> docker-compose up
```

You could scale host containers either by adding --scale to the previous command or do the following

```
PS C:\Source\ansible\> docker-compose scale host=3
```

### Configure ssh

Start ssh service on each host:

```
 PS C:\Source\ansible\tools> .\tools\start-sshd.ps1
```

Then login to the host containers and set password using passwd command.

```
 PS C:\Source\ansible\tools> docker exec -it ansible_host_1 bash
 root@283283:/# passwd
```

Then login to the controller and generate ssh key and copy it to each host

```
 PS C:\Source\ansible\tools> docker exec -it ansible_controller bash
 root@283283:/# ssh-keygen
 then copy it to each host
 root@283283:/# ssh-copy-id -i ansible_host_1
```

For testing ssh, enter the following command, it should not ask for password

```
root@283283:/# ssh ansible_host_1
```

Finnaly you could test your ansible in the controller:

*Node:* If you have more than one host container, you need to update /etc/ansible/hosts file.

```
root@283283:/# ansible -m ping nodes
```

The respons eshould be:

```
ansible_host_1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

#### Cleanup

Stop the ansible containers by:

```
PS C:\Source\ansible\> docker-compose down
```