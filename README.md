# nordhat_install

2020 update : Do not use the old install instructions and DO NOT update Norns from the main menu anymore.

https://github.com/okyeron/fates/blob/master/install/norns/Norns_disk_image_install.md


You can now install Norns using the Fates disk image provided by Okyeron. You just need to overwrite the config.txt and copy the two overlays provided here.

1 : Flash the disk image of Fates to the SD Card using Balena Etcher.

2 : Mount the SD card

3 : Replace config.txt in /boot with the file provided here in the "resources" folder

4 : Move the two .dbto files to /boot/overlays

5 : Unmount the card load it on the RPI and power it on.

6 : Configure the wifi from the Norns menu

7 : Ssh to the RPI and sudo raspi-config -> change the wifi country  + timezone, expand the filesystem and reboot.

Done.
