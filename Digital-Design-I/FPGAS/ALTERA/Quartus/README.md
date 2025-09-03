# Quartus II and USB Blaster using Linux

This are guidelines regarding the instaltion of Quartus II 13.0 and 24.1. on ubuntu 22.04. It is important to note that the 13.1 is very old so there are things deprecated which require custom fix. Disclaimer

## Disclaimer 
The notes below are collated from various sources in the Internet.

There is **NO GUARANTEE** these notes or scripts will work

These notes are a best effort to install Quartus 13.0 and 24.1 on Ubuntu 22.04. They are subject to change in the light of new information.

**Use at your own risk**. Neither the author or the University of Plymouth accept any liability for content of this repository.

## Download and install Ubuntu 22.04 LTS

You will need an installation of Ubuntu Desktop 22.04 LTS. This can be obtained from https://ubuntu.com/download/desktop

Your will need to sign in a user with sudo rights (the default)

I have performed tests with both a Physical machine and a virtual machine (with USB pass-through).

### Install ubuntu packages for Quartus Instalation
```bash
ARCH=$(dpkg --print-architecture)
# enable amd64 and i386 packages
sudo dpkg --add-architecture amd64

sudo dpkg --add-architecture i386

sudo apt-get update

sudo apt-get install build-essential

sudo apt-get install gcc-multilib g++-multilib \lib32z1 lib32stdc++6 lib32gcc-s1:amd64 \expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 \libcanberra0:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 \libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 \libxt6:i386 libxtst6:i386 zlib1g-dev:i386 zlib1g-dev:amd64
```


## Download Quartus

The version we are using is Intel Quartus 13.0sp1 web edition and Intel Quartus Prime Lite Edition, v24.1 

You will probably need to create an account on the Intel site.

### Quartus 13.0sp1 webedition
At the time of writing, a direct link [can be found here](https://www.intel.com/content/www/us/en/software-kit/711790/intel-quartus-ii-web-edition-design-software-version-13-0sp1-for-linux.html)

We download the following

- Intel® Quartus® II Software (includes Nios® II EDS)
- Intel® Cyclone® II, Intel® Cyclone® III, Intel® Cyclone® IV Device Support (includes all variations)

Note: The version of modelism is very problematic, it is recomended to install a new version (e.g., Questa*-Altera FPGA and Starter Editions of the v24.1)

### Quartus Lite 24.1 

At the time of writing, a direct link [can be found here](https://www.intel.com/content/www/us/en/software-kit/849769/intel-quartus-prime-lite-edition-design-software-version-24-1-for-linux.html)

We download the following:

- Quartus® Prime (includes Nios II EDS)
- Questa*-Altera FPGA and Starter Editions
- Intel® Quartus® Prime Programmer and Tools 24.1std.0.1077
- Cyclone® V device support

#### Obtain a free License for Questa*-Intel® FPGA Starter Edition

For Questa, you will also need a license for your machine (linked to the hardware address of your network interface)

Visit the [Intel® FPGA Self-Service Licensing Center](https://www.intel.com/content/www/us/en/docs/programmable/683472/21-4/fpga-self-service-licensing-center.html) and create a single free license for Questa*-Intel® FPGA Starter Edition

This results in a license file (extension .DAT) being emailed to your registered email address. You need to save this file on your machine.


## Install Quartus and Questa

Download all the installers for Quartus and Questa. You only need to run the Quartus Lite installer (this will install Questa for you)

All the files should be in the same folder. I am going to install locally (for just one user). We will discuss installing globally later.

Open a terminal and change to the directory with all the installers and type (select only the version of Quartus you need to install):

```bash
chmod +x QuartusSetupWeb-13.0.1.232.run # for quartus 13.0
chmod +x QuartusLiteSetup-24.1std.0.1077-linux.run # for quartus 24.1
```

This makes the installer executable. Now run the installer as follows:

```bash
./QuartusSetupWeb-13.0.1.232.run #install Quartus 13.0
./QuartusLiteSetup-24.1std.0.1077-linux.run #install Quartus 24.1
``` 

Follow the instructions on screen. By the end of this process, you should have an icon on the desktop. You might need to right-click this to allow it to be executable.

Note also that the precise filenames shown above might have changed by the time you do this.

### Install libpng12-0 for Quartus 13.0

Run the bash script provided in this repository as follows:

```bash
bash install-libpng32.sh <quartus root>/linux #<quartus root corresponds to the full path where quartus was installed e.g. /home/ubuntu/altera/13.0sp1/quartus>
bash install-libpng64.sh <quartus root>/linux64 #<quartus root corresponds to the full path where quartus was installed e.g. /home/ubuntu/altera/13.0sp1/quartus>
```

### Export environmetal variables

Open the `~/.bashrc` using nano:

```bash
nano ~/.bashrc
```
Edit the following text accordingly adn the add it to the `~/.basrc` file
```bash
export QROOT="<path to quartus>" # replace <path to quartus> with the path e.g., /home/ubuntu/altera/13.0sp1
export QUARTUS_ROOTDIR="$QROOT/quartus"
export QSYS_ROOTDIR="$QUARTUS_ROOTDIR/sopc_builder/bin"
export PATH="$PATH:$QUARTUS_ROOTDIR/bin"
export PATH="$PATH:<path to Questasim>/bin" #replace <path to Questasim> with the path e.g., /home/ubuntu/altera_lite/24.1std/questa_fse
```

## Setting up the Programmer (USB Blaster)
To allow Quartus to program your board, we must add a udev rule enabling access to the USB-Blaster programming hardware on the board. Create the text file `/etc/udev/rules.d/51-usbblaster.rules` **(requires superuser privileges)** and populate it with the following:

```bash
# USB-Blaster
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6002", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6003", MODE="0666"

# USB-Blaster II
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="0666"
```
Restart your computer 

You can verify that you are able to program your Board by disconnecting and reconnecting it to your computer and running `./jtagconfig` in the same terminal you ran the above commands. If your setup is correct, you should see output that looks like:
1) USB-Blaster [1-2]

031050DD 10M50DA(.|ES)/10M50DC