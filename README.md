# NSBoot-v. 4.0.0
Diskless boot Windows/Linux - Free Analog CCBoot 

<h1>Games, Internet cafe, Schools</h1>
<h2>Viruses are no longer scary, no unauthorized changes</h1>

* Just restart your computer and the system state will return.
* If you have a lot of computers. There is no need to have hard disks on workstations with this technology
* Web based interface
* Linux based server
  - ZFS optimized storage 
  - Cached
  - Fast I/O perfomants
* Diskless boot from iscsi - Windows/Linux/Mac and other OS


This project is intended to be a free replacement for technology ccboot.
===
- Ubuntu : 
 apt install -y etherwake shellinabox qemu-utils lua-json lua-socket lua-posix nginx-extras zfsutils-linux
 
#> sudo zpool create -m /srv nsboot0 <disk> <disk> cache <disk>
#> sudo  zfs create    -o mountpoint=/srv/images nsboot0/images                   
#> sudo  zfs create    -o mountpoint=/srv/images/boot nsboot0/images/boot              
#> sudo  zfs create    -o mountpoint=/srv/images/boot/snap nsboot0/images/boot/snap          
#> sudo  zfs create    -o mountpoint=/srv/images/games nsboot0/images/games                
#> sudo  zfs create    -o mountpoint=/srv/images/snap nsboot0/images/snap                
#> sudo  zfs create    -o mountpoint=/srv/images/storages nsboot0/images/storages
#> sudo  zfs create    nsboot0/writeback         

if created zvol, example:
#> sudo  zfs create -V60G -o snapdev=visible nsboot0/images/storages/lord.qcow2
 
 


========================================

 TODO:
- [x] Base resty generic [LUA 5.3] 
- [x] nbd devices process detach from nginx [/usr/bin/nsbootd]
- [x] init stripc start/stop/status/reload [/etc/init.d/nsbootd]
- [ ] Web interface
- [ ] Installer system
- [x] vhd/qcow/qcow2/vmdk/vhdx parrent images
- [x] AutoRemove child images on boot system if not super mode
- [ ] Autoremove child images if disconnect iscsi more keep-alive connect
- [ ] GUI Installer system
- [ ] ShellInaboxd
- [ ] Windows agent nsboot
