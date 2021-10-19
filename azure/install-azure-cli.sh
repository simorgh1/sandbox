#!/bin/bash

sudo apt-get update && sudo apt-get install -y libssl-dev libffi-dev python3-dev build-essential
curl -L https://aka.ms/InstallAzureCli | bash