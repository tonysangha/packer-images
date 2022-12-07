# Automated Build of Windows 10 Pro using HashiCorp Packer for VMware Fusion

This repository contains the [Packer](https://www.packer.io/) configuration, which will build a [Windows 10](https://www.microsoft.com/en-au/windows/get-windows-10) VMware fusion virtual machine. The VM will be built with the following software packages:

- Cloudflare for Teams Public certificate
- Cloudflare Warp
- Google Chrome
- Mozilla Firefox
- Notepad++
- PowerShell core
- Putty
- VMware Tools
- WinSCP
- Windows Terminal

## Requirements

To facilitate the build, ensure you have [Packer](https://www.packer.io/) installed. On macOS it can be installed using HomeBrew: `brew install packer`. For all other operating systems, refer to Packer documentation. 

In addition, ensure you have:

- Installed [VMware Fusion Professional](https://www.vmware.com/au/products/fusion/fusion-evaluation.html)
- Created a directory called `ISO` under `$HOME`. This can be done with the following command: `mkdir ~/ISO`.
- Downloaded the Windows 10 x64 - English (November 2021 update) from [Microsoft](https://www.microsoft.com/en-au/software-download/windows10ISO) and placed the file into the ISO directory. 
    - Filename should be: `Win10_21H2_English_x64.iso`
- If you want to use a different image, update the `iso_checksum` in the `win-10-fusion.pkr.hcl` file with the new sha256 value. 

## Execute Build

Once you have completed the pre-reqs, to build the image execute the command: `packer build win-10-fusion.pkr.hcl`

Username and password for the Windows VM is as follows:

- User: `acme`
- Pass: `P@$$w0rd`

Post provisioning you can set the VM to use the `bridged` adapter instead of NAT with the following command:

`vmrun -t fusion setNetworkAdapter  ~/Virtual\ Machines/win10/win-10.vmx 0 bridged`
