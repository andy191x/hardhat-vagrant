#/bin/bash

echo "Configuring system..."

cd /root

# Install system utilities
apt -y update
apt -y install net-tools locate

# Setup build environment
apt -y install build-essential

# Install node
# https://github.com/nodesource/distributions/blob/master/README.md
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
apt install -y nodejs
which node || exit 1
which npm || exit 1

# Add jump to project folder upon login (for dev.sh)
echo 'cd ~/project' >> /root/.profile
echo '' >> /root/.profile

# Initialize project
pushd /root/project
bash project_init.sh
popd

# Finalize install
updatedb

echo "Done."

exit 0
