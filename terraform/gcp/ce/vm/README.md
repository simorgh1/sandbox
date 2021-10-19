# Create a virtual machine instance in google cloud using terraform

Required: 

- A google cloud account, if you don't have one yet, create one here: [free Google Cloud account](https://cloud.google.com/free/).
- Computer Engine API must be enabled
- Terraform (is preinstalled in Cloud Shell)

Login to your [account](https://console.cloud.google.com/home/dashboard) console and go to cloud shell placed in the menu bar in the top right corner.

![IMAGE](https://github.com/simorgh1/terraform/raw/master/gcp/ce/vm/img/cloud-shell-menu.jpg)

## What is terraform?

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing, popular service providers as well as custom in-house solutions.

Terraform should be already installed in the cloud shell environment, you could check it with `terraform version`

You could check the authenticated account which will be used by terraform in order to connect to the Compute Cloud API.

```bash
$ gcloud auth list
Credentialed Accounts
ACTIVE  ACCOUNT
*       your@email
To set the active account, run:
    $ gcloud config set account `ACCOUNT`
```

The active project can be listed with:

```bash
$ gcloud config list project
[core]
project = <your project id>

Your active configuration is: [cloudshell-24816]
```

## Creating the VM configuration file

Open Cloud Shell editor using the menu bar.

![IMAGE](https://github.com/simorgh1/terraform/raw/master/gcp/ce/vm/img/open-editor-cloud-shell.jpg)

Now you could continue in the editor to create the required terraform configuration file. 
Create a new file named instance.tf and add the following content into it:

```javascript
resource "google_compute_instance" "default" {
  project      = "<your project id>"
  name         = "terraform"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
```

Replace the project if placeholder with your project id retrieved in the previous command. 

## Initialization

The first command to run for a new configuration -- or after checking out an existing configuration from version control -- is terraform init. This will initialize various local settings and data that will be used by subsequent commands.

At this stage terraform downloads the required Google provider plugin.

The terraform plan command is used to create an execution plan, enter terraform plan, so that terraform knows which resources are going to be created or modified.

**Hint**: You could use this command always before git commit in order to ensure the current state of your resources.

## Applying the changes

In the current folder where the instance.tf is located enter `terraform apply`.

After that terraform will report the created virtual machine instance.
You could show the current configuration at any time by using the `terraform show` command

### Check the created Virtual machine instance in console

Go to Compute Engine from the left menu and select VM Instances, a new vm instance named terraform should be in running state.
You could connect into it using ssh using your google cloud credential in the current web browser!

### Delete the Virtual machine instance

This could be done by invoking the `terraform destroy` command

This will delete the virtual machine istance and the related resources.

### Summary

Using terraform one could manage resources, in this example we created a new Virtual Machine Instance in the Google Cloud Compute Engine. 

After cnhecking the created vm instance we destroyed it with terraform.

If you want to preserve the current state and follow the [GitOps](https://www.gitops.tech/#what-is-gitops) principles, you should checkin the state file as well, since the current resources are all listed in it.
If some one else wants to continue using the created resources, terraform initialization will download the required provider plugin and with plan command, the current state will be compared with checked in configuration file, and you are good to go.
