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
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
apt install -y nodejs
which node || exit 1
which npm || exit 1

# Install solc
# From: https://github.com/ethereum/solidity/releases
pushd /usr/local/bin
wget -O solc-0.8.9 https://github.com/ethereum/solidity/releases/download/v0.8.9/solc-static-linux
chmod +x solc-0.8.9
if [ -f solc ]; then
	unlink solc
fi
ln -s solc-0.8.9 solc
popd

# Add jump to project folder upon login (for dev.sh)
echo 'cd ~/project' >> /root/.profile
echo '' >> /root/.profile

# Add "hardhat" command alias
echo '' >> /root/.bashrc
echo 'alias hardhat="npx hardhat"' >> /root/.bashrc
echo '' >> /root/.bashrc

# Initialize project
pushd /root/project
bash project_init.sh
popd

# Finalize install
updatedb

echo "Done."

exit 0
