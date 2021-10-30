#/bin/bash

if [ -f Vagrantfile ]; then
	curl -O Vagrantfile https://raw.githubusercontent.com/andy191x/hardhat-vagrant/main/Vagrantfile
	curl -O dev-provision.sh https://raw.githubusercontent.com/andy191x/hardhat-vagrant/main/dev-provision.sh
fi

vagrant up && vagrant ssh -c 'sudo -i'

exit 0
