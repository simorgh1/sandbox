set -e

# Installing az beta, since az official does not support arm64 on mac m1
apt-get update
apt-get install python3-pip -y

python3 -m pip install --upgrade pip
pip install --extra-index-url https://azcliprod.blob.core.windows.net/beta/simple/ azure-cli

echo "Done!"