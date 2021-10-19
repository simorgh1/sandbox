## Setup Raspberry pi 4 B

### Hardware: 

- Raspberry pi 4B 
- SD 64G SanDisk
- USB Cabel for USB Model C Adapter
- Powerbank 10k

### OS: raspbian

First I've downloaded raspbian in order to explorer what uis out of the box installed, but at the end I will adapt the installation for my setup, where I want to have docker installed and add my applications using docker.

[Download raspbian](https://www.raspberrypi.org/downloads/raspbian/)

For flashing the image after unzipping into my SD card, I have downloaded balendaEtcher for windows.

[Download balenaEtcher](https://www.balena.io/etcher/)

[balena.io](https://www.balena.io/) has very interesting application where you could add your device and your setup configuration for wifi, and then you could download a ready to use image, where you could run your application as well, I will have a look into it later ;-)

### Wifi auto-configuration

Update the wpa_supplicant.conf with your wifi information and copy it into your sd card after Etcher is finished. It will configure and connect into the wifi after booting. Keep in mind, the in this setup we have no keyboard/mouse or monitor attached into the raspberry pi and we want to use it in headless mode and connect with ssh

### Enabling ssh server on first boot

Copy a file named ssh into the sd card, that's it, ssh server will start on first boot and ssh file will be removed. Please read [security update for raspbian pixel](https://www.raspberrypi.org/blog/a-security-update-for-raspbian-pixel/) for more information.

### First boot

Connect the USB C Cabel part with the power USB C of Raspberry pi, the other end into the Powerbank, then the red and green leds start to blink, after couple of seconds, the system is up and running and you could ping it either by name raspberrypi or check it's ip in your router.

### Connect to raspberry pi

In Windows 10, open a PowerShell windows and use 

```
PS C:\> ssh pi@raspberrypi
```

The default password is raspberry, please change it after first login.

### Connect using xRdp

Easy to setup, please follow [this guide](https://www.datenreise.de/en/raspberry-pi-install-remote-desktop-xrdp/) and install xRdp, after that you could use windows Remote Desktop Client and connect into Raspberry pi.

### Conclusion

In this guide, we setup raspberry pi 4b for first boot, with wifi and ssh server auto configured and enabled, then connected to the device first using ssh client in windows, then with Microsoft Remote Desktop Client. No direct mouse/keyboard or monitor used!