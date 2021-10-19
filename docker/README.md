# Content

## Elasticsearch & Kibana docker Stack

Spins up an Elasticsearch & Kibana Stack with one node and embeded elasticsearch configuration file.

## How to run pihole inside docker toolbox

No docker engine on your machine available, like Windows 10 Home or mac os? then install docker tollbox and start testing pihole in order ot get rid of **un-invited guests**!

## Ansible controller and host docker stack

You want to dig into ansible but have no linux environment? 
This docker images provide host and controller images and in a defined stack you could try the capabilities of ansible playbooks. 
For more information on how to scale the docker stack to n running ansible hosts, check the [README](ansible/README.md).

## Aspnet.core samples Docker & k8s

Multi-staged asp.net core dockerfiles ans basic k8s deployment for 

* Simple mvc app
* Using kubernetes configMap in order to store appsettings.
* Using kubernetes configMap in order to store secrets.
* A docker stack for aspnet core and PostgreSQL + pgadmin.
