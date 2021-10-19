resource "null_resource" "raspberry_pi_bootstrap" {
  connection {
    type     = "ssh"
    user     = var.username
    password = var.password
    host     = var.raspberrypi_ip
  }

  provisioner "remote-exec" {
    inline = [
      
      # INSTALL Telegraf
      "curl -fsSL https://raw.githubusercontent.com/simorgh1/terraform/master/raspberrypi-bootstrap/install-telegraf.sh -o install-telegraf.sh",
      "chmod +x install-telegraf.sh",
      "sudo ./install-telegraf.sh",

      # INSTALL docker 
      "curl -fsSL https://raw.githubusercontent.com/simorgh1/terraform/master/raspberrypi-bootstrap/install-docker.sh -o install-docker.sh",
      "chmod +x install-docker.sh",
      "sudo ./install-docker.sh",
      
      # SYSTEM AND PACKAGE UPDATES
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get dist-upgrade -y",
      "sudo apt --fix-broken install -y",

      # DATE TIME CONFIG
      "sudo timedatectl set-timezone ${var.timezone}",
      "sudo timedatectl set-ntp true"
    ]
  }
}
