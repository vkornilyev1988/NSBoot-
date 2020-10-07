local 	nsboot 							= {}
		nsboot.cfg 						= {}
		nsboot.cfg.server 				= {}
		nsboot.cfg.iscsi 				= {}
		nsboot.cfg.dhcp 				= {}
		nsboot.cfg.dhcp.config			= {}
		nsboot.cfg.dhcp.config.global	= {}
		nsboot.cfg.dhcp.config.opt 		= {}
		nsboot.cfg.dhcp.config.sub 		= {}
		nsboot.cfg.tftp 				= {}
		nsboot.files 					= {}
		nsboot.cfg.web 					= {}


--[[=================================[NSBOOT]=========================================]]		
nsboot.cfg.server.vendor 				= "Nuke Technology LLC"
nsboot.cfg.server.version				= "4.0.0"
nsboot.cfg.server.ipv4					= "192.168.0.2"
nsboot.cfg.server.mask					= "255.255.255.0"
nsboot.cfg.server.gateway				= "192.168.0.210"
nsboot.cfg.server.dns1					= "8.8.8.8"
nsboot.cfg.server.dns2					= "8.8.4.4"
nsboot.cfg.server.workdir				= "/srv"
nsboot.cfg.server.tftp					= "tftp"
nsboot.cfg.server.distdir				= "nsboot"
nsboot.cfg.server.imgdir				= "/srv/nsboot/images/boot"
nsboot.cfg.server.imgdatadir			= "/srv/nsboot/images/games"
nsboot.cfg.server.imgbackdir			= "/srv/nsboot/writeback"
nsboot.cfg.server.config				= "nsboot.json"
nsboot.cfg.server.image_prefix			= "_child_"
nsboot.cfg.server.debug					= 1
nsboot.cfg.server.nbd_max_part			= 63
nsboot.cfg.server.nbd_nbds 				= 20
nsboot.cfg.server.daemon				= nil

--[[=================================[ISCSI]==========================================]]

nsboot.cfg.iscsi.iqn 					= "2020-02-10.com.nsboot"
nsboot.cfg.iscsi.listen 				= "0.0.0.0"
nsboot.cfg.iscsi.port 					= 3260
nsboot.cfg.iscsi.proto					= 6


--[[=================================[WKS ]===========================================]]
nsboot.cfg.wks 							= {}
nsboot.cfg.wks[1] 						= {}
nsboot.cfg.wks[2] 						= {}
nsboot.cfg.wks[3]                       = {}
nsboot.cfg.wks[1].mac					= "b4:2e:99:2c:dd:52"	
nsboot.cfg.wks[1].ipv4					= "192.168.0.3"
nsboot.cfg.wks[1].name  				= "PC003"
nsboot.cfg.wks[1].enable 				= 1
nsboot.cfg.wks[1].tid					= 1
nsboot.cfg.wks[1].supper				= 0
nsboot.cfg.wks[1].fileboot 				= "ipxe"
nsboot.cfg.wks[1].img 					= {}
nsboot.cfg.wks[1].img[1] 				= {}
nsboot.cfg.wks[1].img[1].path			= "win10cc.qcow2"
nsboot.cfg.wks[1].img[1].boot 			= 1
nsboot.cfg.wks[1].img[1].nbd			= "/dev/nbd1"
nsboot.cfg.wks[1].img[1].cache 	 		= "unsafe"
nsboot.cfg.wks[1].img[1].type 			= "dyndisk"
nsboot.cfg.wks[1].img[1].enable 		= 1
nsboot.cfg.wks[1].img[2] 				= {}
nsboot.cfg.wks[1].img[2].path			= "lord.qcow2"
nsboot.cfg.wks[1].img[2].boot 			= 0
nsboot.cfg.wks[1].img[2].nbd			= "/dev/nbd2"
nsboot.cfg.wks[1].img[2].cache 	 		= "unsafe"
nsboot.cfg.wks[1].img[2].type 			= "dyndata"
nsboot.cfg.wks[1].img[2].enable 		= 1
nsboot.cfg.wks[1].img[3] 				= {}
nsboot.cfg.wks[1].img[3].path			= "Install.iso"
nsboot.cfg.wks[1].img[3].boot 			= 0
nsboot.cfg.wks[1].img[3].nbd			= "/dev/nbd0"
nsboot.cfg.wks[1].img[3].cache 	 		= "unsafe"
nsboot.cfg.wks[1].img[3].type 			= "iso"
nsboot.cfg.wks[1].img[3].enable 		= 0
nsboot.cfg.wks[1].swp					= 0
nsboot.cfg.wks[1].opt					= {}
nsboot.cfg.wks[1].opt[1]				= "ipxe.keep-san 1"
nsboot.cfg.wks[1].opt[2]				= "ipxe.no-pxedhcp 1"

---------------------------------------------------------------------
nsboot.cfg.wks[2].mac					= "b4:2e:99:2c:dd:df"	
nsboot.cfg.wks[2].ipv4					= "192.168.0.4"
nsboot.cfg.wks[2].name  				= "PC004"
nsboot.cfg.wks[2].enable 				= 1
nsboot.cfg.wks[2].tid					= 2
nsboot.cfg.wks[2].supper				= 0
nsboot.cfg.wks[2].fileboot 				= "ipxe"
nsboot.cfg.wks[2].img 					= {}
nsboot.cfg.wks[2].img[1] 				= {}
nsboot.cfg.wks[2].img[1].path			= "win10cc.qcow2"
nsboot.cfg.wks[2].img[1].boot 			= 1
nsboot.cfg.wks[2].img[1].nbd			= "/dev/nbd3"
nsboot.cfg.wks[2].img[1].cache 	 		= "unsafe"
nsboot.cfg.wks[2].img[1].type 			= "dyndisk"
nsboot.cfg.wks[2].img[1].enable 		= 1
nsboot.cfg.wks[2].img[2] 				= {}
nsboot.cfg.wks[2].img[2].path			= "lord.qcow2"
nsboot.cfg.wks[2].img[2].boot 			= 0
nsboot.cfg.wks[2].img[2].nbd			= "/dev/nbd4"
nsboot.cfg.wks[2].img[2].cache 	 		= "unsafe"
nsboot.cfg.wks[2].img[2].type 			= "dyndata"
nsboot.cfg.wks[2].img[2].enable 		= 1
nsboot.cfg.wks[2].img[3] 				= {}
nsboot.cfg.wks[2].img[3].path			= "Install.iso"
nsboot.cfg.wks[2].img[3].boot 			= 0
nsboot.cfg.wks[2].img[3].nbd			= "/dev/nbd0"
nsboot.cfg.wks[2].img[3].cache 	 		= "unsafe"
nsboot.cfg.wks[2].img[3].type 			= "iso"
nsboot.cfg.wks[2].img[3].enable 		= 0
nsboot.cfg.wks[2].swp					= 0
nsboot.cfg.wks[2].opt					= {}
nsboot.cfg.wks[2].opt[1]				= "ipxe.keep-san 1"
nsboot.cfg.wks[2].opt[2]				= "ipxe.no-pxedhcp 1"

--[[=================================[DHCP]===========================================]]

nsboot.cfg.dhcp.listen 									= "0.0.0.0"
nsboot.cfg.dhcp.port 									= 67
nsboot.cfg.dhcp.workdir									= "/etc/dhcp"
nsboot.cfg.dhcp.config.global['authoritative'] 			= ""
nsboot.cfg.dhcp.config.global['default-lease-time'] 	= 600
nsboot.cfg.dhcp.config.global['max-lease-time'] 		= 7200
nsboot.cfg.dhcp.config.global['ddns-update-style']  	= "none"
nsboot.cfg.dhcp.config.global['next-server'] 			= nsboot.cfg.server.ipv4
nsboot.cfg.dhcp.config.opt['domain-name'] 				= "nsboot.local"
nsboot.cfg.dhcp.config.opt['domain-name-servers'] 		= nsboot.cfg.server.dns1
nsboot.cfg.dhcp.config.opt['subnet-mask'] 				= nsboot.cfg.server.mask
nsboot.cfg.dhcp.config.opt['broadcast-address']			= "192.168.0.255"
nsboot.cfg.dhcp.config.opt['routers'] 					= nsboot.cfg.server.gateway
nsboot.cfg.dhcp.config.sub[1] 							= {}
nsboot.cfg.dhcp.config.sub[1].sub 						= "192.168.0.0"
nsboot.cfg.dhcp.config.sub[1].mask 						= "255.255.255.0"
nsboot.cfg.dhcp.config.sub[1].ranges 					= {}
nsboot.cfg.dhcp.config.sub[1].ranges[1] 				= "192.168.0.10 192.168.0.149"
nsboot.cfg.dhcp.config.sub[1].ranges[2] 				= "192.168.0.180 192.168.0.200"
nsboot.cfg.dhcp.config.ipxe 							= [[
		option space ipxe;
		option ipxe-encap-opts code 175 = encapsulate ipxe;
		option ipxe.priority code 1 = signed integer 8;
		option ipxe.keep-san code 8 = unsigned integer 8;
		option ipxe.skip-san-boot code 9 = unsigned integer 8;
		option ipxe.syslogs code 85 = string;
		option ipxe.cert code 91 = string;
		option ipxe.privkey code 92 = string;
		option ipxe.crosscert code 93 = string;
		option ipxe.no-pxedhcp code 176 = unsigned integer 8;
		option ipxe.bus-id code 177 = string;
		option ipxe.bios-drive code 189 = unsigned integer 8;
		option ipxe.username code 190 = string;
		option ipxe.password code 191 = string;
		option ipxe.reverse-username code 192 = string;
		option ipxe.reverse-password code 193 = string;
		option ipxe.version code 235 = string;
		option iscsi-initiator-iqn code 203 = string;
		# Feature indicators
		option ipxe.pxeext code 16 = unsigned integer 8;
		option ipxe.iscsi code 17 = unsigned integer 8;
		option ipxe.aoe code 18 = unsigned integer 8;
		option ipxe.http code 19 = unsigned integer 8;
		option ipxe.https code 20 = unsigned integer 8;
		option ipxe.tftp code 21 = unsigned integer 8;
		option ipxe.ftp code 22 = unsigned integer 8;
		option ipxe.dns code 23 = unsigned integer 8;
		option ipxe.bzimage code 24 = unsigned integer 8;
		option ipxe.multiboot code 25 = unsigned integer 8;
		option ipxe.slam code 26 = unsigned integer 8;
		option ipxe.srp code 27 = unsigned integer 8;
		option ipxe.nbi code 32 = unsigned integer 8;
		option ipxe.pxe code 33 = unsigned integer 8;
		option ipxe.elf code 34 = unsigned integer 8;
		option ipxe.comboot code 35 = unsigned integer 8;
		option ipxe.efi code 36 = unsigned integer 8;
		option ipxe.fcoe code 37 = unsigned integer 8;
		option ipxe.vlan code 38 = unsigned integer 8;
		option ipxe.menu code 39 = unsigned integer 8;
		option ipxe.sdi code 40 = unsigned integer 8;
		option ipxe.nfs code 41 = unsigned integer 8;
		#option no proxy
		option ipxe.no-pxedhcp 1;
]]
--[[=================================[tftp]==========================================]]
nsboot.cfg.tftp.port 								= 69
nsboot.cfg.tftp.workdir								= "/srv/tftp"
--[[=================================[tftp]==========================================]]
nsboot.cfg.web.pages = {}
nsboot.cfg.web.pages.ipxe = {}
nsboot.cfg.web.pages.ipxe.body = [[
#!ipxe
console --picture tftp://${next-server}/bg.png
console --picture tftp://${next-server}/bg.png --left 32 --right 32 --top 32 --bottom 48
:MENU
menu Selection
item normal Boot normal (unsafe) 	- [ISCSI]
item unsafe supper mode  		- [ISCSI]
item hwtest Test hardware (ram and other hw)
item shell Start shell [_>]
item memtest memtest x86_64
item linux Boot linux Desktop
item reboot Reboot computer
choose input && goto ${input}

:hwtest
sanboot iso/slitaz-rolling.iso || prompt
goto MENU

:shell
shell || prompt
goto MENU


:reboot
reboot
]] --console --x 1024 --y 768
nsboot.cfg.web.pages.ipxe.footer = [[
:normal
sanboot ${root-path} || prompt


:unsafe
echo http://${next-server}:8888?supper=true&user=${user}&pass=${pass}
echo sanboot ${root-path} || prompt
choose input
]]

nsboot.cfg.web.pages.main = {}
nsboot.cfg.web.pages.main.html = [[


]]

return nsboot