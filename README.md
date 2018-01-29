
## Hur?
 1. install debian 9 with a desktop environment

 2. login with your user.

 3. get the scripts above by opening a terminal and running
 ´´´
 $ wget https://raw.githubusercontent.com/gSCReAM/installscript/master/pa-gst-setup.sh -O pa-gst-setup.sh
$ wget https://raw.githubusercontent.com/gSCReAM/installscript/master/pa-sys-setup.sh -O pa-sys-setup.sh
 ´´´

 4. make both script executable by running
 ´´´
 $ chmod +x pa-gst-setup.sh
 $ chmod +x pa-sys-setup.sh
 ´´´

 5. the scripts are ready to run.

 6. change from stable to testing, update and reboot system.
 first we need to be root so in a terminal type ´su´ and when prompted enter the ´root users´ password
 then simply run ´pa-sys-setup.sh´ script
 ´´´
 # ./pa-sys-setup.sh
 ´´´
 after the script is finished the system will reboot.

 7. Prepare for gst-uninstalled installation.
 open a terminal and  run the ´pa-gst-setup.sh´ script
 this script will download packages needed for the initial setup of the gst-environment. in a terminal run:
 ´´´
 $ sudo ./pa-gst-setup.sh
 ´´´
 the script will run. after the script is finished it leaves us inside the gst-uninstalled environment.

 8. finish the gst-uninstalled setup by running
 ´./gstreamer/scripts/git-update.sh´ as asked at the end
  of the previous script.
  sit back and wait this might take some time...
