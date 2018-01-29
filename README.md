# Readme
Here are two script's to help with setting up the system, prepare for and install the _gst-uninstalled_ environment

## The scripts.
### The `pa-sys-setup.sh` script will

* Update the sources.list file with `apt-get update`
* Install _sudo_
* Prompt for which user to add to the sudo group
* Backup _sources.list_ and change from __stable__ branch to __testing__ branch.
* Update packages with `apt-get upgrade` and dist `apt-get dist-upgrade`
* Once finished __reboot__ the system.

### The `pa-gst-setup.sh` script will

* Install the following packages
  * git
  * curl
  * bison
  * flex
  * yasm
  * guvcview
  * net-tools
  * atom
* Install dependencies for gstreamer 1.0
  * base
  * good
  * bad
  * ugly
* Create a `bin/` directory in the users home folder
* Fetch and run the __gst-uninstalled__ create script.
* Place a symlink in the previous mentioned bin/ directory for easy access to the __gst-uninstalled__ environment
* When done leave the user __inside__ the __gst-uninstalled__ environment

### How to use the scripts
* both scripts should be made executable
  * `$ chmod +x pa-sys-setup.sh`
  * `$ chmod +x pa-gst-setup.sh`
* the `pa-sys-setup.sh` script should be run as root.
  * `# ./pa-sys-setup.sh`
* the `pa-gst-setup.sh` script should be run as user.
  * `$ ./pa-gst-setup.sh`

## How to install.
### Prerequisites
* Debian 9 linux system or a distribution that is based on debian
* Desktop environment
* root access
* having turned off the following is recommended if on a a virtual machine
  * screen lock (privacy settings. _see virtual machine section_)
  * blank screen (power option. _see virtual machine section_)

### Getting the scripts
As a normal user open up a terminal and download the script.
```
$ wget https://raw.githubusercontent.com/gSCReAM/installscript/master/pa-sys-setup.sh -O pa-sys-setup.sh
$ wget https://raw.githubusercontent.com/gSCReAM/installscript/master/pa-gst-setup.sh -O pa-gst-setup.sh

```
this will download two scripts: `pa-gst-setup.sh`, `pa-gst-setup.sh` and place them in your current directory.

### make the scripts executable
```
$ chmod +x pa-sys-setup.sh
$ chmod +x pa-gst-setup.sh
```

### Run the first script.
In a terminal change to the root user by doing the following.
```
$ su
```
and type in your root passwod when asked.

the terminal prefix for normal user `$` should now have been changed to the of a root user `#`

We can now run the `pa-sys-setup.sh` script by doing the following:
```
# ./pa-sys-setup.sh
```
__15s__ after the script is finished the system will reboot.
Once the system boots up again we can continue with the second script.

### Run the second script.
Open a terminal. Provided you're in the directory where you previously saved the scripts run the following:
```
$ sudo ./pa-gst-setup.sh
```
this will install all packets needed to successfully build the gst-uninstalled environment.

once the script is finished it will leave us inside of the gst-uninstalled environment and we are now ready to run the last script which has been setup automatically for us.

### Run the third script.
Inside the gst-uninstalled environment run the following to complete the setup.
```
./gstreamer/scripts/git-update.sh
```
this might take __a while__

## Virtual machine
working on it...
