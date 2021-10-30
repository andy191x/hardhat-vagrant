#/bin/bash

if [ -f "package.json" ]; then
	# Project already exists, install packages
	echo "Project already exists, installing modules..."
	rm -rf node_modules
	npm install || exit 1
	exit 0
fi

# Create new project
echo "Creating new project..."
#npm config set bin-links=false
npm install --save-dev hardhat || exit 1
npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers || exit 1

echo "Done."

exit 0
