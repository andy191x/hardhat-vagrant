# hardhat-vagrant

One-step private development sandbox for Hardhat/Solidity projects on Windows/Mac/Linux desktops.

## Usage

* Install prerequisites (see below).
* Save the latest [dev.sh](https://raw.githubusercontent.com/andy191x/hardhat-vagrant/main/dev.sh) from this repository to a folder for your next Hardhat project.
* Open a terminal, run: `bash dev.sh`.

```
bash dev.sh        # (host)  spawn new VM. if the VM exists, a new terminal will be opened instead.
vagrant destroy    # (host)  destroy the VM.
hardhat <command>  # (guest) shortcut alias for "npx hardhat"
```

## Prerequisites (Windows 10)

* Install [Git Bash](https://gitforwindows.org/)
* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install [Vagrant](https://www.vagrantup.com/downloads)
* Enable symlinks (see below)

### Enable symlinks

This is required because the host project folder is shared with the VM. Hardhat is built on NodeJS which creates a local `node_modules` folder. Inside `node_modules`, files are linked with symlinks. Symlinks are disabled for user accounts by default on Windows. (More info: [Link 1](https://www.speich.net/articles/en/2018/12/24/virtualbox-6-how-to-enable-symlinks-in-a-linux-guest-os/) [Link 2](https://github.com/npm/npm/issues/992#issuecomment-289935776) ).

```
Cmd -> "whoami". Copy user account name.
Run -> "secpol.msc".
Edit "Local Policies" -> "User Rights Assignment" -> "Create symbolic links".
Add user account name and save.
Logoff/login or reboot.
Cmd -> "whoami /priv". If successful, "SeCreateSymbolicLinkPrivilege" will appear in the list. It may show as "Disabled", but that's safe to ignore.
```

## Prerequisites (MacOS)

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install [Vagrant](https://www.vagrantup.com/downloads)

(This project should work on MacOS, but has not been tested yet)

---

## How does it work?

The `hardhat-vagrant` scripts use VirtualBox, Vagrant, and Ubuntu's official Vagrant box to create an Ubuntu-based, local development sandbox. The `dev.sh` script downloads the provisioning scripts from this repository and kicks off the VM creation process through Vagrant.
