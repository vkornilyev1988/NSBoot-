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
nsboot.cfg.server.imgisodir				= "/srv/nsboot/images/iso"
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
nsboot.cfg.wks[1].img[3].path			= "Win10_2004_Russian_x64.iso"  
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
nsboot.cfg.wks[2].img[3].path			= "WinPE10_8_Sergei_Strelec_x86_x64_2019.12.28_Russian.iso"
nsboot.cfg.wks[2].img[3].boot 			= 0
nsboot.cfg.wks[2].img[3].nbd			= "/dev/nbd0"
nsboot.cfg.wks[2].img[3].cache 	 		= "unsafe"
nsboot.cfg.wks[2].img[3].type 			= "iso"
nsboot.cfg.wks[2].img[3].enable 		= 1
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
set keep-san 1
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
sanboot ${root-path} || sanboot ${root0} || sanboot ${root1} prompt


:unsafe
echo http://${next-server}:8888?supper=true&user=${user}&pass=${pass}
echo sanboot ${root-path} || prompt
choose input
]]

nsboot.cfg.web.pages.html = {}
nsboot.cfg.web.pages.html.css = [[ *,:after,:before{box-sizing:inherit}html{box-sizing:border-box;font-size:62.5%}body{font-family:Roboto,'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:1.6em;font-weight:300;letter-spacing:.01em;line-height:1.6;margin:0;color:#495057;background-color:#f5f7fb}hr{margin-top:5em}a{text-decoration:none;color:#ff1493}.hide{display:none}.loader{height:4px;width:100%;position:fixed;overflow:hidden;z-index:3;top:53px}.loader:before{display:block;position:absolute;content:"";left:-200px;width:200px;height:4px;background-color:#ff5722;-webkit-animation:loading 2s linear infinite;animation:loading 2s linear infinite}@keyframes loading{from{left:-200px;width:10%}50%{width:30%}70%{width:70%}80%{left:50%}95%{left:120%}to{left:100%}}.cont{margin-right:auto;margin-left:auto;margin-bottom:5em;margin-top:5rem;padding-right:2rem;padding-left:2rem}.row{padding:0 10px;box-sizing:border-box;display:-webkit-box;display:flex;-webkit-box-flex:0;flex:0 1 auto;-webkit-box-orient:horizontal;-webkit-box-direction:normal;flex-direction:row;flex-wrap:wrap;margin-right:-.5rem;margin-left:-.5rem}.of-s0,.of-s1,.of-s10,.of-s11,.of-s12,.of-s2,.of-s3,.of-s4,.of-s5,.of-s6,.of-s7,.of-s8,.of-s9,.s,.s1,.s10,.s11,.s12,.s2,.s3,.s4,.s5,.s6,.s7,.s8,.s9{box-sizing:border-box;-webkit-box-flex:0;flex:0 0 auto;padding-right:.5rem;padding-left:.5rem}.s{-webkit-box-flex:1;flex-grow:1;flex-basis:0;max-width:100%}.s1{flex-basis:8.33333333%;max-width:8.33333333%}.s2{flex-basis:16.66666667%;max-width:16.66666667%}.s3{flex-basis:25%;max-width:25%}.s4{flex-basis:33.33333333%;max-width:33.33333333%}.s5{flex-basis:41.66666667%;max-width:41.66666667%}.s6{flex-basis:50%;max-width:50%}.s7{flex-basis:58.33333333%;max-width:58.33333333%}.s8{flex-basis:66.66666667%;max-width:66.66666667%}.s9{flex-basis:75%;max-width:75%}.s10{flex-basis:83.33333333%;max-width:83.33333333%}.s11{flex-basis:91.66666667%;max-width:91.66666667%}.s12{flex-basis:100%;max-width:100%}.of-s0{margin-left:0}.of-s1{margin-left:8.33333333%}.of-s2{margin-left:16.66666667%}.of-s3{margin-left:25%}.of-s4{margin-left:33.33333333%}.of-s5{margin-left:41.66666667%}.of-s6{margin-left:50%}.of-s7{margin-left:58.33333333%}.of-s8{margin-left:66.66666667%}.of-s9{margin-left:75%}.of-s10{margin-left:83.33333333%}.of-s11{margin-left:91.66666667%}@media only screen and (min-width:48em){.m,.m1,.m10,.m11,.m12,.m2,.m3,.m4,.m5,.m6,.m7,.m8,.m9,.of-m0,.of-m1,.of-m10,.of-m11,.of-m12,.of-m2,.of-m3,.of-m4,.of-m5,.of-m6,.of-m7,.of-m8,.of-m9{box-sizing:border-box;flex:0 0 auto;padding-right:.5rem;padding-left:.5rem}.m{-webkit-box-flex:1;flex-grow:1;flex-basis:0;max-width:100%}.m1{flex-basis:8.33333333%;max-width:8.33333333%}.m2{flex-basis:16.66666667%;max-width:16.66666667%}.m3{flex-basis:25%;max-width:25%}.m4{flex-basis:33.33333333%;max-width:33.33333333%}.m5{flex-basis:41.66666667%;max-width:41.66666667%}.m6{flex-basis:50%;max-width:50%}.m7{flex-basis:58.33333333%;max-width:58.33333333%}.m8{flex-basis:66.66666667%;max-width:66.66666667%}.m9{flex-basis:75%;max-width:75%}.m10{flex-basis:83.33333333%;max-width:83.33333333%}.m11{flex-basis:91.66666667%;max-width:91.66666667%}.m12{flex-basis:100%;max-width:100%}.of-m0{margin-left:0}.of-m1{margin-left:8.33333333%}.of-m2{margin-left:16.66666667%}.of-m3{margin-left:25%}.of-m4{margin-left:33.33333333%}.of-m5{margin-left:41.66666667%}.of-m6{margin-left:50%}.of-m7{margin-left:58.33333333%}.of-m8{margin-left:66.66666667%}.of-m9{margin-left:75%}.of-m10{margin-left:83.33333333%}.of-m11{margin-left:91.66666667%}}@media only screen and (min-width:75em){.l,.l1,.l10,.l11,.l12,.l2,.l3,.l4,.l5,.l6,.l7,.l8,.l9,.of-l0,.of-l1,.of-l10,.of-l11,.of-l12,.of-l2,.of-l3,.of-l4,.of-l5,.of-l6,.of-l7,.of-l8,.of-l9{box-sizing:border-box;-webkit-box-flex:0;flex:0 0 auto;padding-right:.5rem;padding-left:.5rem}.l{-webkit-box-flex:1;flex-grow:1;flex-basis:0;max-width:100%}.l1{flex-basis:8.33333333%;max-width:8.33333333%}.l2{flex-basis:16.66666667%;max-width:16.66666667%}.l3{flex-basis:25%;max-width:25%}.l4{flex-basis:33.33333333%;max-width:33.33333333%}.l5{flex-basis:41.66666667%;max-width:41.66666667%}.l6{flex-basis:50%;max-width:50%}.l7{flex-basis:58.33333333%;max-width:58.33333333%}.l8{flex-basis:66.66666667%;max-width:66.66666667%}.l9{flex-basis:75%;max-width:75%}.l10{flex-basis:83.33333333%;max-width:83.33333333%}.l11{flex-basis:91.66666667%;max-width:91.66666667%}.l12{flex-basis:100%;max-width:100%}.of-l0{margin-left:0}.of-l1{margin-left:8.33333333%}.of-l2{margin-left:16.66666667%}.of-l3{margin-left:25%}.of-l4{margin-left:33.33333333%}.of-l5{margin-left:41.66666667%}.of-l6{margin-left:50%}.of-l7{margin-left:58.33333333%}.of-l8{margin-left:66.66666667%}.of-l9{margin-left:75%}.of-l10{margin-left:83.33333333%}.of-l11{margin-left:91.66666667%}}.start{-webkit-box-pack:start;justify-content:flex-start;text-align:start}.center{-webkit-box-pack:center;justify-content:center;text-align:center}.end{-webkit-box-pack:end;justify-content:flex-end;text-align:end}.left{float:left}.right{float:right}.fix.nav{position:fixed;top:0;width:100%;z-index:5}.nav{overflow:hidden;margin:0;padding:0;list-style-type:none;background:#000}.nav li{float:left;margin-bottom:0}.nav li a{display:inline-block;padding:14px 16px;transition:.3s;text-align:center;text-decoration:none;color:#fff}.nav li a.brand{font-weight:700;margin-right:20px;margin-left:40px}.active,.nav li a:hover{background:rgba(255,255,255,.2)}.nav li.-icon{display:none}.-exit{float:right!important}@media screen and (max-width:48em){.m-cont{width:95%!important}.-exit{float:none!important}.nav li:not(:first-child){display:none}.nav li.-icon{display:initial;float:right}.-icon a{font-size:3rem;padding:1px 20px!important}.nav.res li.-icon{position:absolute;top:0;right:0}.nav.res li{display:inline;float:none}.nav.res li a{display:block;text-align:left}}.group{position:relative;margin-top:1.5em}input,input[type=radio]+label,select{text-align:left;width:100%;padding:.5em;background-color:#f9f9f9;color:#000;border:1px solid #bbb;border-radius:3px;-webkit-transition:.35s ease-in-out;-moz-transition:.35s ease-in-out;-o-transition:.35s ease-in-out;transition:all .35s ease-in-out}input:disabled{opacity:.5}button{text-align:center;padding:.5em;min-width:5em;font-size:1.3em;line-height:1;background-color:#f9f9f9;border:1px solid #e5e5e5;border-radius:5px;-webkit-transition:.35s ease-in-out;-moz-transition:.35s ease-in-out;-o-transition:.35s ease-in-out;transition:all .35s ease-in-out;color:#000}button:disabled{background-color:#faebd7;opacity:.7}button:hover{opacity:.8;border-color:#888;outline:0}input[type=radio]{display:none}input[type=radio]+label{font-size:1.3em;display:inline-block;width:50%;text-align:center;float:left;border-radius:0;font-weight:700;line-height:1.15}input[type=radio]+label:first-of-type{border-top-left-radius:5px;border-bottom-left-radius:5px}input[type=radio]+label:last-of-type{border-top-right-radius:5px;border-bottom-right-radius:5px}input[type=radio]+label i{padding-right:.4em}input:checked+label:before,input[type=radio]:checked+label{background-color:inherit;color:#fff}input[type=number],input[type=password],input[type=text]{font-size:1.2em;-moz-appearance:textfield -moz-padding-start:13px}input[type=checkbox]{position:absolute;z-index:-1;opacity:0;margin:10px 0 0 20px}input[type=checkbox]+label{position:relative;padding:0 0 0 60px;cursor:pointer}.group input[type=checkbox]+label{top:8px}.group span{font-size:14px;position:absolute;pointer-events:none;left:10px;top:-20px;font-style:normal;color:#000}input[type=checkbox]+label:before{content:'';position:absolute;top:-4px;left:0;width:50px;height:26px;border-radius:13px;background:#cdd1da;box-shadow:inset 0 2px 3px rgba(0,0,0,.2);transition:.2s}input[type=checkbox]+label:after{content:'';position:absolute;top:-2px;left:2px;width:22px;height:22px;border-radius:10px;background:#fff;box-shadow:0 2px 5px rgba(0,0,0,.3);transition:.2s}input[type=checkbox]:checked+label:before{background:#7ed321}input[type=checkbox]:checked+label:after{left:26px}input[type=checkbox]:focus+label:before{box-shadow:inset 0 2px 3px rgba(0,0,0,.2),0 0 0 3px rgba(255,255,0,.7)}input[type=color]{width:6em;height:3.15em;padding:0;margin-left:10px}input:checked+label:after{opacity:1}input:invalid{border:1px solid red}.invalid{border:1px solid red}select{line-height:1.2;font-size:1.2em;font-weight:700;-webkit-appearance:none;-moz-appearance:none;appearance:none}select:first-of-type{border-top-left-radius:3px;border-bottom-left-radius:3px}select:last-of-type{border-top-right-radius:3px;border-bottom-right-radius:3px}select:active,select:focus{outline:0},input[type=number],input[type=password],input[type=text]{display:block}input:focus{outline:0}input[type=color]+label,input[type=number]+label,input[type=password]+label,input[type=text]+label{font-weight:400;position:absolute;pointer-events:none;left:10px;top:10px;transition:.2s ease all;-moz-transition:.2s ease all;-webkit-transition:.2s ease all}input[type=color]+label{top:-20px;font-size:14px}input[type=number]:focus~label,input[type=number]:valid~label,input[type=password]:focus~label,input[type=password]:valid~label,input[type=text]:focus~label,input[type=text]:valid~label{top:-20px;font-size:14px}input[type=number]:focus,input[type=number]:hover{-moz-appearance:number-input}input[type=range]{-webkit-appearance:none;height:12px;padding:0}input[type=range]+label{position:absolute;top:-20px;left:10px}input[type=range]::-webkit-slider-thumb{-webkit-appearance:none;background-color:#7ed321;border-radius:50%;width:25px;height:25px}input[type=range]::-moz-range-thumb{background-color:#7ed321;border-radius:50%;width:25px;height:25px}input[type=range]::-moz-range-track{width:100%;background:#fff}.ver{display:inline-block;width:10%;height:170px;margin-left:20px}.ver input+label{left:-15px}.ver input{width:150px;transform-origin:75px 75px;transform:rotate(-90deg)}.three input[type=radio]+label{width:33%}.four input[type=radio]+label{width:25%}.five input[type=radio]+label{width:20%}.search{border:1px solid #bbb;border-radius:5px;background-color:#f9f9f9;text-align:left}.search input{border:0;width:60%}.search [type=submit]{border:0;width:auto;float:right;font-size:1.2em}.search ul{list-style:none;margin:auto;text-align:left}.search li{padding:.3em .5em;margin-left:-2.5em}.search li:hover{font-weight:700;background-color:#e8e8e8}.alert{padding:1em;margin:1em;border-radius:.5em;opacity:1;transition:opacity .6s}table{border-spacing:0;width:100%}td,th{border-bottom:.1rem solid #e1e1e1;padding:1.2rem 0;text-align:left}tr:hover{background-color:#f1f1f1}.progbar{position:relative;width:100%;height:30px;border-radius:5px;background-color:#d3d3d3}.progbar .bar{position:absolute;width:1%;height:100%;border-radius:5px;background-color:#87cefa}.progbar .label{line-height:30px;text-align:center;color:#fff}.round{border-radius:25px!important}.small{font-size:60%!important;padding:7px 20px!important}.large{font-size:125%!important;padding:20px 50px!important}.danger{background-color:#f44336!important}.success{background-color:#7ed321!important}.info{background-color:#2196f3!important}.warning{background-color:#ff9800!important}.purple{background-color:#ce08ce!important}.primary{background-color:#33c3f0!important}.grey{background-color:#ddd!important}.danger,.info,.primary,.purple,.success,.warning{color:#fff!important}.close{color:inherit;float:right;font-size:3rem;line-height:20px;cursor:pointer;transition:.5s;padding:3px}.close:hover{color:#000}.modal{position:fixed;z-index:6;padding-top:100px;left:0;top:0;width:100%;height:100%;overflow:auto;background-color:rgba(0,0,0,.4);opacity:1;transition:opacity .6s}.m-cont{background-color:#fefefe;margin:auto;border:1px solid #888;width:70%;border-radius:10px;padding:15px}.m-body{padding:15px;overflow:scroll;padding-top:5px;margin:15px 20px}.m-foo{text-align:end}.sidenav{position:fixed;left:0;top:0;width:0;height:100%;z-index:4;background-color:#fff;overflow-x:hidden;transition:.5s;border-right:2px solid #0000004f}.sidenav .in{height:54px}.sidenav a{padding:8px 8px 8px 32px;text-decoration:none;font-size:20px;color:#000;display:block;transition:.3s;white-space:nowrap}.l-g{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column;padding-left:0;margin-bottom:0;overflow-x:hidden}.lg-i span{float:right;padding:0 6px;border-radius:6px}.lg-i:hover{background-color:#efefef}.lg-i{position:relative;display:block;padding:.75rem 1.25rem;margin-bottom:-1px;background-color:#fff;border:1px solid rgba(0,0,0,.125)}::-webkit-scrollbar{width:6px}::-webkit-scrollbar-thumb{border-width:1px 1px 1px 2px;border-color:#777;background-color:#aaa}::-webkit-scrollbar-thumb:hover{border-width:1px 1px 1px 2px;border-color:#555;background-color:#777}::-webkit-scrollbar-track{border-width:0}::-webkit-scrollbar-track:hover{border-left:solid 1px #aaa;background-color:#eee}.hover{transition:box-shadow .25s,-webkit-box-shadow .25s}.hover:hover{box-shadow:0 8px 17px 0 rgba(0,0,0,.2),0 6px 20px 0 rgba(0,0,0,.19)}.card{position:relative;display:-ms-flexbox;display:flex;-ms-flex-direction:column;flex-direction:column;min-width:0;word-wrap:break-word;background-color:#fff;background-clip:border-box;border:1px solid rgba(0,40,100,.12);border-radius:3px}.card .card-title.activator{cursor:pointer}.card .card-image{position:relative}.card .card-image img{display:block;border-radius:2px 2px 0 0;position:relative;left:0;right:0;top:0;bottom:0;width:100%}.card .card-image .card-title{color:#fff;position:absolute;bottom:0;left:0;max-width:100%;padding:24px}.card .card-content{padding:24px;border-radius:0 0 2px 2px;transition:.3s linear}.card .card-content p{margin:0}.card .card-content .card-title{display:block;line-height:32px;margin-bottom:8px}.card .card-content .card-title i{line-height:32px}.card .card-reveal{padding:24px;position:absolute;background-color:#fff;width:100%;overflow-y:auto;left:0;top:100%;height:100%;z-index:1;display:none;transition:.3s linear}.card .card-reveal .card-title{cursor:pointer;display:block}.p-0{padding:0!important}.p-1{padding:.25rem!important}.p-2{padding:.5rem!important}.p-3{padding:.75rem!important}.p-4{padding:1rem!important}.p-5{padding:1.5rem!important}.p-6{padding:2rem!important}.p-7{padding:3rem!important}.p-8{padding:4rem!important}.p-9{padding:6rem!important}.footer{background:#fff;border-top:1px solid rgba(0,40,100,.12);font-size:1.25rem;color:#9aa0ac;position:fixed;width:100%;bottom:0}.footer a:hover{text-decoration:underline}.footer a{color:#6e7687;font-size:1.3rem}.footer li{display:inline!important}} ]]
nsboot.cfg.web.pages.html.js =  [[ window.onload=function(){var int;var scanStart;var settings;function send(page,data,callback){var req=new XMLHttpRequest();req.open("POST",page,true);req.setRequestHeader('Content-Type','application/json');req.addEventListener("load",function(){if(callback)(req.status===200)?callback(req.responseText):callback(false)});req.send(JSON.stringify(data))}function parse(text){try{return JSON.parse(text)}catch(err){return false}}function $(val){return document.getElementById(val)}function loadSettings(){send("init_settings.lua",{def:1},function(res){$('loader').classList.add('hide');var data=parse(res);if(!data){}else{settings=data;$('pwd').value=data.pwd;$('ssid').value=data.ssid;$('login').value=data.login;$('pass').value=data.pass;$('mode').value=data.mode;$('auth').value=(data.auth===true)}})}function check_sel(val){var s=$(val);for(var i=0;i<s.options.length;i++){if(s.options[i].selected){return s.options[i].value}}}function logout(){document.cookie="id=";location.href='/login.html'}function save(){var data={Fname:"setting.json"};var arr=["ssid","pwd","mode","pass","login","auth"];arr.forEach(function(item,i,arr){if(item==="mode"){data[item]=+check_sel(item)}else if(item==="auth"){data[item]=check_sel(item)=="true"}else{var x=$(item).value;if(x||x!=='')data[item]=x}});if(+check_sel("mode")===0){if(!confirm("Attention !!! Wi-Fi will be disabled, do you really want it?"))return}$('loader').classList.remove('hide')$('modal').classList.add("hide");send("init_settings.lua",{save:data},function(res){if(res==="true"){send("web_control.lua",{reboot:true},function(res){setTimeout(function(){location.href="/"},10000)})}})}var x=["|","(|","((|","(((|","((((|"];var y=0;function ani(){if(y>4){y=0}document.getElementById('search').value=x[y];y=y+1}function scan(){if(!scanStart){scanStart=true;int=setInterval(ani,200);send("web_control.lua",{scan:true},function(res){});setTimeout(function(){send("get_network.json",{},function(res){scanStart=false;if(res){clearInterval(int);y=0;$('search').value="Search...";try{var j=JSON.parse(res);var i=1;var buf='';for(key in j){var data=j[key].split(",")buf+='<li id="'+key+'"><b>'+key+'</b> rssi : '+data[1]+' channel : '+data[3]+'</li>';i++}$('list').innerHTML=buf}catch(e){$('list').innerHTML='<li>No networks found</li>'}$('list').style.display='block'}})},5000)}}loadSettings();document.body.addEventListener("click",function(event){var id=event.target.id;if(id==="search")scan();if(id==="btn_exit")logout();if(id==="save_m")save();if(id==="btn_save")$('modal').classList.remove("hide");if(id==="close"||id==="close_m")$('modal').classList.add("hide");if(event.target.tagName==="LI"){var a=$('list');if(id){$('ssid').value=id;$('pwd').value="";$('pwd').focus();$('mode').value="1"}a.style.display='none'}})};var settings={};function send(page,data,callback){var req=new XMLHttpRequest();req.open("POST",page,true);req.setRequestHeader('Content-Type','application/json');req.addEventListener("load",function(){if(req.status<400){callback(req.responseText)}else{callback(false)}});req.send(JSON.stringify(data))}function listLink(){for(i=0;i<localStorage.length;i++){var myKey=localStorage.key(i);if(myKey=="web.info")continue;myKey=myKey.split(".")console.log(myKey);var a=document.createElement('a');a.href="plugin.html?plugin="+myKey[0];a.style.color="black"a.innerHTML='<li class="lg-i">'+myKey[0]+'</li>'list.appendChild(a)}}function loadURl(src){var load;if(src.indexOf(".js")!=-1){load=document.createElement('script');load.src=src;load.async=false}else{load=document.createElement("link");load.setAttribute("rel","stylesheet");load.setAttribute("type","text/css");load.setAttribute("href",src)}document.head.appendChild(load);load.onload=function(){document.getElementById("loader").classList.add('hide')};load.onerror=function(){}}function card(obj){var temp='<div class="card hover">'+'<div class="card-image"'+(obj.info.img?'style="background: url('+obj.info.img+') center center / cover no-repeat;"':'')+'></div>'+'<div class="card-content"><span title="Module name" class="card-title">'+obj.info.name+'</span>'+'<div class="tia run"></div>'+'<div class="group btnInfo">'+'<input title="autostart module" '+(obj.init.run?"checked ":"")+'type="checkbox" id="run" />'+'<label for="run"></label></div>'+'<span class="vers" title="Installed version">version <b>'+obj.info.version+'</b></span><p>'if(typeof(obj.info.page)==='object'){obj.info.page.forEach(function(item,i,arr){temp+='<a title="/'+item+'" target="_blank" href="'+item+'">link </a>'})}else{temp+='<a title="/'+obj.info.page+'" target="_blank" href="'+obj.info.page+'">link</a>'}temp+='</p><p><b>Description : </b>'+obj.info.description+'</p>'+'<p><b>Modules : </b>'+obj.info.modules.join(", ")+'</p>'+'<span class="git b"><a target="_blank" href="'+obj.info.repository.url+'">GitHub</a></span>'+'</div>'+'</div>'return temp}function create(html,id,c){var e=document.createElement('div');e.className=c;e.innerHTML=html;document.getElementById(id).appendChild(e)}window.onload=function(){listLink();document.getElementById('loader').classList.add('hide');var url=new URL(window.location.href);var param=url.searchParams.get("plugin");if(param){send(param+".init",{},function(res){if(res){try{settings.init=JSON.parse(res);settings.info=JSON.parse(localStorage.getItem(param+".info"))}catch(e){console.log(e);return}load(settings);create(card(settings),"info","s12");if(settings.info.script){setTimeout(function(){loadURl(settings.info.script)},2000)}else{document.getElementById("loader").classList.add('hide')}}})}};function text(obj,val){var temp='<div class="group">'+'<input id="'+obj.id+'" type="text" required="" value="'+obj.valInit+'">'+'<label for="'+obj.name+'">'+obj.name+'</label>'+'</div>'return temp}function number(obj){var temp='<div class="group">'+'<input id="'+obj.id+'" title="min='+obj.min+', max='+obj.max+'" type="number" min="'+obj.min+'" max="'+obj.max+'" required="" value="'+obj.valInit+'">'+'<label for="'+obj.id+'">'+obj.name+'</label></div>'return temp}function select(obj){var temp='  <div class="group"><select id="'+obj.id+'" name="'+obj.id+'">'obj.values.forEach(function(item,i,arr){if(item===obj.valInit){temp+='<option selected value="'+item+'">'+item+'</option>'}else{temp+='<option value="'+item+'">'+item+'</option>'}})temp+='</select><span>'+obj.name+'</span></div>'return temp}function load(sett){var native=sett.info.native;console.log(native);native.forEach(function(item,i){if(i!==0){var obj=item;obj.valInit=sett.init[item.id];if(obj.type==="number"){create(number(obj),"plugin","s6")}else if(obj.type==="select"){create(select(obj),"plugin","s6")}else{create(text(obj),"plugin","s6")}}})}function validate(n){var id=document.getElementById(n);var val=id.value;if(val.length===0)return false;if(id.type==="number"){var min=+id.getAttribute('min');var max=+id.getAttribute('max');if(val<min||val>max)return false}return true}function save(){var temp={};var valid=true;for(var key in settings.init){var id=document.getElementById(key);if(!validate(key)){alert("Error in input field "+key);valid=false}if(id.type==="checkbox"){temp[key]=id.checked}else if(id.type==="number"){temp[key]=+id.value}else if(id.type==="select-one"){temp[key]=isNaN(+id.value)?id.value:+id.value}else{temp[key]=id.value}}if(valid){temp.Fname=settings.info.name+".init";var saveInfo=document.getElementById("saveInfo");saveInfo.innerHTML="Saving"send("init_settings.lua",{save:temp},function(res){if(res){saveInfo.innerHTML="Saved"}else{saveInfo.innerHTML="Error"}console.log(res);setTimeout(function(){saveInfo.innerHTML="Save"reboot(true)},2000)})}console.log(temp)}function def(){var native=settings.info.native;console.log(native)native.forEach(function(item,i){console.log(item.val)if(item.type==="checkbox"){console.log(item.id)document.getElementById(item.id).checked=item.val}else if(item.type==="select"){var s=document.getElementById(item.id);for(var i=0;i<s.options.length;i++){s.options[i].selected=false;if(s.options[i].value==item.val){s.options[i].selected=true}}}else{document.getElementById(item.id).value=item.val}})}function del(){send("init_settings.lua",{del:settings.info.files},function(res){console.log(res);document.getElementById("loader").classList.remove('hide');if(res){localStorage.removeItem(settings.info.name+".info");setTimeout(function(){location.href='/index.html'},1000)}})}function logout(){document.cookie="id=";location.href='/login.html'}function reboot(d){if(d){document.getElementById("Modal").style.display="block"}else{document.getElementById("loader").classList.remove('hide');send("web_control.lua",{reboot:true},function(res){document.getElementById("Modal").style.display="none";setTimeout(function(){location.href="/"},10000)})}}function modClose(){document.getElementById("Modal").style.display="none"} ]]

nsboot.cfg.web.pages.html.login = [[
<!DOCTYPE html>
<html lang="ru">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta http-equiv="Content-Language" content="en" />
<meta name="msapplication-TileColor" content="#2d89ef">
<meta name="theme-color" content="#4188c9">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta charset="UTF-8">
  <div id="loader" class="header"></div>
  <ul class="nav fix info" id="navbar">
    <li><a href="index.html" class="brand"><img src="" >NSBoot</a></li>
    <li class="-icon"><a href="#" onclick="document.getElementById('navbar').classList.toggle('res');">&equiv;</a></li>
  </ul>


  <title>Login</title>
  <style>

    small:hover {
      color: #000000cc;
      cursor: pointer;
      text-decoration: underline;
    }

    small {
      padding-top: 1rem;
      float: right;
    }

    button {
      width: 100%;
    }
]]..nsboot.cfg.web.pages.html.css..[[
  </style>
<script>
]]..nsboot.cfg.web.pages.html.js..[[
</script>
</head>

<body>

  <div class="cont">
    <div class="row">
      <div class="card s12 m4 of-m4 p-6">
        <h1 class="center">Login</h1>
        <div class="group">
          <input type="text" id="login" name="login" required=" " value="">
          <label for="login">LOGIN</label>
        </div>
        <div class="group">
          <input type="password" name="pass" id="pass" required=" " value="">
          <label for="pass">PASSWORD</label>
        </div>
        <div>
          <small id="def">*Default login "<b>admin</b>" password "<b>0000</b>"</small>
        </div>
        <div class="group">
          <button class="info" id="singIn">Sing in</button>
        </div>
      </div>
    </div>
  </div>
  //= template/footer.html
  <script>
    window.onload = function() {

      function $(val) {
        return document.getElementById(val);
      }

      document.getElementsByName('pass')[0].focus();

      function send(page, data, callback) {
        var req = new XMLHttpRequest();
        req.open("POST", page, true);
        req.setRequestHeader('Content-Type', 'application/json');
        req.addEventListener("load", function() {
          if (callback)(req.status === 200) ? callback(req.responseText) : callback(false)
        });
        req.send(JSON.stringify(data));
      }

      $('singIn').addEventListener("focus", function() {
        var data = {};
        data.login = $("login").value;
        data.pass = $("pass").value;
        send("web_control.lua", {
          auth: data
        }, function(res) {
          console.log(res)
          if (res == "false") {
            $('login').classList.add('invalid');
            $('pass').classList.add('invalid');
          } else {
            document.cookie = "id=" + res;
            document.cookie = "ids=" + res;
            location.href = '/';
          }
        })
      })

      $('def').addEventListener("click", function() {
        $('login').value = "admin";
        $('pass').value = "0000";
      });

      $('login').addEventListener("focus", function() {
        $('login').classList.remove('invalid');
        $('pass').classList.remove('invalid');
      });

      $('pass').addEventListener("focus", function() {
        $('login').classList.remove('invalid');
        $('pass').classList.remove('invalid');
      });

      document.onkeyup = function(e) {
        e = e || window.event;
        if (e.keyCode === 13) {
          login();
        }
        return false;
      }
    }

  </script>
</body>

</html>

]]
nsboot.cfg.web.pages.html.main = [[
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="3">
<style>
#customers{font-family:"Trebuchet MS",Arial,Helvetica,sans-serif;border-collapse:collapse;width:100%}#customers td,#customers th{border:1px solid #ddd;padding:8px}#customers tr:nth-child(even){background-color:#f2f2f2}#customers tr:hover{background-color:#ddd}#customers th{padding-top:12px;padding-bottom:12px;text-align:left;background-color:#4caf50;color:#fff}
</style></head><body><table id="customers"><tr><th>ID</th><th>HOSTNAME</th><th>IP ADDRESS</th><th>MAC </th><th>STATUS</th><th>SUPPER</th><th>BOOT FILE</th><th>IMG0</th><th>IMG1</th><th>IMG2</th></tr>

]]
nsboot.cfg.web.themes = {}
nsboot.cfg.web.themes.default = {}
--nsboot.cfg.web.themes.default.css = dofile("/home/kevin/srv/nsboot/modules/bootstrap_grid.lua");




return nsboot