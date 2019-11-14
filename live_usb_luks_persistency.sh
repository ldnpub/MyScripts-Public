#!/bin/bash
#sdc                                                                                
#├─sdc1   ext4        Sctipts 7e337cff-f7b2-4d86-8732-59e0dcbd7f10 /media/scripts
#└─sdc2   crypto_LUKS         9b176760-7045-4067-81e0-9ab89e6b0b4e 
#  └─HOME ext4                c07856f1-edc0-4298-9b51-a330478119c1 /home

PROFILE=rodolphe

if [ $USER != root ]; then
	echo "Please run a root"
	exit 1
fi

setxkbmap fr fr

mkdir /media/scripts 
umount UUID=7e337cff-f7b2-4d86-8732-59e0dcbd7f10
mount UUID=7e337cff-f7b2-4d86-8732-59e0dcbd7f10 /media/scripts

#cryptsetup luksOpen /dev/sdc2 HOME
cryptsetup luksOpen UUID=9b176760-7045-4067-81e0-9ab89e6b0b4e HOME
#mount /dev/mapper/HOME /home/
mount UUID=c07856f1-edc0-4298-9b51-a330478119c1 /home/

echo "############################"
 
useradd -M -r -s /bin/bash $PROFILE
sed -i "/$PROFILE/d" /etc/shadow

echo "$PROFILE:\$6\$yJO8dMaA\$5jRSMj22YuX/.vzWhraZ8bfSoFOsEm2Lrd3WG7MUrHl031j5YhLI4oL9KH.keBofrMnyMUtdtjiK.4sK79p0R.:18208:0:99999:7:::" >> /etc/shadow

usermod -aG sudo $PROFILE
usermod -aG $PROFILE $PROFILE
chown -R $PROFILE: /home/$PROFILE

echo " 
#######################################
#  You may now log into your account  #
#######################################
"
