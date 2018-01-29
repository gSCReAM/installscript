#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;34m'
BOLD='\033[1m'
NBOLD='\033[0m'

DATE=`date '+%Y-%m-%d-%H-%M-%S'`
tmpfile=/tmp/pasetup.$DATE.log
echo -e "starting script" >> $tmpfile
if [ "$EUID" -ne 0 ]
then echo -e "This script must be run as ${RED}${BOLD}root${NC}${NBOLD}"
echo -e "not root exiting" >> $tmpfile
exit
fi
echo -e "${GREEN}+${NC} updating mirrors"
apt-get update &>> $tmpfile
echo "Which user to setup sudo for?"
read -p 'user: ' suser
echo -e "${GREEN}+${NC} Installing and setting up sudo for user ${BOLD}${suser}${NBOLD}"
apt-get -qq -y install sudo &>> $tmpfile
sudo usermod -aG sudo ${suser}
echo -e "\n adding ${suser} to sudo group\n" >> $tmpfile
echo -e "\nChanging from ${GREEN}${BOLD}stable${NBOLD}${NC} to ${RED}${BOLD}testing${NBOLD}${NC}"
cp /etc/apt/sources.list /etc/apt/sources.list.back
sed -i -- 's/stretch/testing/g ' /etc/apt/sources.list
echo -e "${GREEN}+${NC} updating mirrors"
apt-get update &>> $tmpfile
echo -e "${GREEN}+${NC} updating packets"
echo -e "\n apt-get upgrade \n" >> $tmpfile
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y &>> $tmpfile
echo -e "${GREEN}+${NC} upgrading dist"
echo -e "\n apt-get dist-upgrade \n" >> $tmpfile
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y  &>> $tmpfile
echo -e "${GREEN}${BOLD}Done.${NBOLD}${NC}\nThe system will ${RED}${BOLD}reboot in 15s${NBOLD}${NC}"
echo -e "\n script done rebooting" >> $tmpfile
sleep 15
reboot
