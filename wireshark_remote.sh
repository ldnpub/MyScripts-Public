#!/bin/bash
read -p "LOGIN ?: " LOGIN
read -p "SERVER|@IP : " SERVER

# Create a named pipe:
mkfifo /tmp/remote

# Start wireshark from the command line
wireshark-gtk -k -i /tmp/remote

# Run tcpdump over ssh on your remote machine and redirect the packets to the named pipe:
ssh $LOGIN@$SERVER "tcpdump -s 0 -U -n -w - -i eth0 not port 22" > /tmp/remote

#########################################################################################


####    Check the tcpdump binary is present:

	# which tcpdump
#/usr/sbin/tcpdump

	# ll /usr/sbin/tcpdump
#-rwxr-xr-x 1 root root 742080 Feb  1  2012 /usr/sbin/tcpdump

##    Have the non-privileged application user own tcpdump:

	# chown tcpdump:tcpdump /usr/sbin/tcpdump

##    Allow others to execute it:

	# chmod 755 /usr/sbin/tcpdump

##    Confirm permissions:

	# ll /usr/sbin/tcpdump
#-rwxr-xr-x 1 tcpdump tcpdump 742080 Feb  1  2012 /usr/sbin/tcpdump

##    Add capabilities to the binary and check them:

	# setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

	# getcap /usr/sbin/tcpdump
##/usr/sbin/tcpdump = cap_net_admin,cap_net_raw+eip

#    Add a link to the binary into the regular user's PATH:

	# ln -s /usr/sbin/tcpdump /usr/local/bin/tcpdump

