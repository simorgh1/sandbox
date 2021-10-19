# Raspberrypi

It's about RaspberryPi 4B with 4G Ram.

## Initial Setup

Setting up the SD card with Raspbian image, then prepare auto wifi configuration and enabling ssh server. In this tutorial you can setup a new RaspberryPi and connect into it using ssh. No need for keyboard, mouse or monitor! [Read more](/Setup).

## Using Pi-hole in docker

Installing Pi-hole as docker container. Works fine and resumes after reboot, [Read more](/Pi-hole)

## CPU temprature using dotnet core

The nuget package Iot.Device.Bindings has the required library for CPU temprature on raspberryPi

## Bootstrap

Before running containers on raspi, it needs some bootstraping, I've used terraform and the code is checked in [here](https://github.com/simorgh1/terraform). It will install docker and telegraf.

## Monitoring

[Monitoring stack](https://github.com/simorgh1/raspberrypi/tree/master/Monitoring) usese grafana, influxdb and telegraf inorder to monitor cpu, network , ram and other metrics of RaspberryPi.
