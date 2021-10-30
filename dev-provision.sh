#/bin/bash

LINE_PREFIX="hardhat-vagrant"
cd /root

# Install system utilities
echo "$LINE_PREFIX: Installing system utilities..."

apt -y update
apt -y install net-tools locate

# Setup build environment
echo "$LINE_PREFIX: Setting up build environment..."

apt -y install build-essential

# Install node
echo "$LINE_PREFIX: Installing node..."

# https://github.com/nodesource/distributions/blob/master/README.md
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
apt install -y nodejs
#which node || exit 1
#which npm || exit 1

# Install solc
echo "$LINE_PREFIX: Installing solc..."

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
echo "$LINE_PREFIX: Adding project jump..."
echo 'cd ~/project' >> /root/.profile
echo '' >> /root/.profile

# Add "hardhat" command alias
echo "$LINE_PREFIX: Adding hardhat alias..."
echo '' >> /root/.bashrc
echo 'alias hardhat="npx hardhat"' >> /root/.bashrc
echo '' >> /root/.bashrc


# Initialize project
echo "$LINE_PREFIX: Initializing project..."

pushd /root/project

if [ -f "package.json" ]; then
	# Project already exists, install packages
	echo "Project already exists, installing modules..."
	rm -rf node_modules
	npm install
else
	echo "Creating new project..."
	#npm config set bin-links=false
	npm install --save-dev hardhat
	npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers
fi

# Finalize install
echo "$LINE_PREFIX: finalizing installation..."
updatedb

# Success
echo "$LINE_PREFIX: Done."

exit 0
