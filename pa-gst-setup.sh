#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NBOLD='\033[0m'
EMPTYLINE=''
#tmpfile=$( /bin/mktemp -t )
ADATE=`date '+%Y-%m-%d'`
DATE=`date '+%Y-%m-%d-%H-%M-%S'`
tmpfile=/tmp/pa-gst-setup.$DATE.log
#echo $DATE
#echo $tmpfile
echo -e "\nThis script might prompt you for your ${RED}${BOLD}password${NBOLD}${NC} multiple times!\n"
echo -e "starting script" >> $tmpfile
echo -e "${GREEN}+${NC} updating mirrors"
sudo apt-get update &>>$tmpfile
get_packets=(git curl bison flex yasm guvcview net-tools)
#get_packets=(curl git)

echo -e "${GREEN}+${NC} installing packets"
for packet in ${get_packets[*]}
do
  echo -e " ${GREEN}+${NC} installing ${PURPLE}${BOLD}${packet}${NBOLD}${NC}"
  #RESPONSE=`sudo apt-get -qq -y install ${packet}`
  sudo apt-get -y install ${packet} &>> $tmpfile
  echo $EMPTYLINE >> $tmpfile
  #echo -e ${RESPONSE} "\n"
  #echo ""
done
echo -e " ${GREEN}+${NC} installing ${PURPLE}${BOLD}atom.${ADATE}.deb${NBOLD}${NC}"
echo -e "  ${GREEN}+${NC} fetching ${PURPLE}${BOLD}atom.${ADATE}.deb${NBOLD}${NC}"
echo -e "Fetching atom.$ADATE.deb\n" >> $tmpfile
wget -nv https://atom.io/download/deb -O atom.$ADATE.deb &>> $tmpfile
echo $EMPTYLINE >> $tmpfile
echo -e "  ${GREEN}+${NC} building ${PURPLE}${BOLD}atom.${ADATE}.deb${NBOLD}${NC}"
echo -e "Installing atom.$ADATE.deb\n" >> $tmpfile
sudo dpkg -i atom.${ADATE}.deb &>>$tmpfile
echo $EMPTYLINE >> $tmpfile
echo -e "  ${GREEN}+${NC} installing dependencies for ${PURPLE}${BOLD}atom.${ADATE}.deb${NBOLD}${NC}"
echo -e "Installing dependencies for atom.$ADATE.deb\n" >> $tmpfile
sudo apt-get install -f -y &>> $tmpfile
echo $EMPTYLINE >> $tmpfile

echo -e "${GREEN}+${NC} building dependencies for gstreamer"
sudo apt-get -y build-dep gstreamer1.0-plugins-{base,good,bad,ugly} &>> $tmpfile
echo $EMPTYLINE >> $tmpfile
echo -e "${GREEN}+${NC} creating directories"
echo -e " ${GREEN}+${NC} ~/bin/"
echo -e "mkdir ~/bin\n" >> $tmpfile
mkdir ~/bin
echo $EMPTYLINE >> $tmpfile
echo -e "${GREEN}+${NC} fetching and running install script"
#curl https://cgit.freedesktop.org/gstreamer/gstreamer/plain/scripts/create-uninstalled-setup.sh | sh
sh <(curl -s https://cgit.freedesktop.org/gstreamer/gstreamer/plain/scripts/create-uninstalled-setup.sh) &>> $tmpfile
echo -e "${GREEN}+${NC} creating symlinks"
ln -sf ~/gst/master/gstreamer/scripts/gst-uninstalled ~/bin/gst-master
echo -e "ln -sf ~/gst/master/gstreamer/scripts/gst-uninstalled ~/bin/gst-master\n" >> $tmpfile
echo -e "${RED}${BOLD} log file is located at ${NBOLD}${NC}${GREEN}${BOLD}${tmpfile}${NBOLD}${NC}"
echo -e "${GREEN}+${NC} entering the gst-uninstalled environment"
echo -e "The script has finished.\n${YELLOW}${BOLD} To complete the setup run \t./gstreamer/scripts/git-update.sh${NBOLD}${NC}\nto leave the gst-unsinstalled envionment just type exit"
~/bin/gst-master
