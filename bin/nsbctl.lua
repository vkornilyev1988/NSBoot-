---#!/usr/bin/lua


--tgtadm --lld iscsi --op new --mode target --tid 1 -T 											#CREATE TARGET
--lld iscsi --op new --mode target --tid --lun 													#ADD LUN
--tgtadm --lld iscsi --op new --mode logicalunit --tid 1 --lun 1 -b /dev/nbd1 					#ADD LUN
--lld iscsi --op delete --force --mode logicalunit --tid --lun 									#REMOVE LUN
--tgtadm --lld iscsi --op show --mode target 													#SHOW TARGET
--lld iscsi --op delete --force --mode target --tid                                            	#REMOVE TARGET FORCE
--lsof -i TCP@0.0.0.0:3260 																		#ибо — скомбинировать все эти ключи
--lsof -i :68 																					#Например, отобразить сервисы, прослушивающие порт 22 и/или уже установленные соединения на этом порту:
--tostring


--[[#>
	[[=============================================================================================================================================================================================]]
	 	nsboot={}
	  	nsboot.cmd = {}
	  	nsboot.lib = {}
	  	nsboot.inc = {}
	  	nsboot.web = {}
	  	nsboot.bin = {}
	  	nsboot.cfg = dofile("/home/kevin/srv/nsboot/modules/cfg.lua").cfg
	--[[===========================================================================================================================================================================================]]
	--[[ TARGET COMMANDS sets opt1,opt2,opt3  ]]
	--[[===========================================================================================================================================================================================]]

		nsboot.lib.json		= require("json");
		nsboot.lib.lfs  	= require("lfs");	
		nsboot.lib.posix	= require("posix");	  	  	
	--[[ TARGET COMMANDS sets opt1,opt2,opt3  ]]
	--[[===========================================================================================================================================================================================]]
	  	nsboot.cmd.tgt = 	{
					new 		= function(opt,p_tid) 	return os.execute("/usr/sbin/tgtadm --lld iscsi --op new --mode target --tid "..p_tid.." -T "..opt); 									end, 					--CREATE TARGET
					destroy		= function(opt) 		return os.execute("/usr/sbin/tgtadm --lld iscsi --op delete --mode target --tid "..opt); 												end, 					--REMOVE TARGET
					kill		= function(opt) 		return os.execute("/usr/sbin/tgtadm --lld iscsi --op delete --force --mode target --tid "..opt); 										end, 					--FORCE REMOVE TARGET
					show 		= function(opt) 		return os.execute("/usr/sbin/tgtadm --lld iscsi --op show --mode target "..opt); 														end, 					--INFO TARGETS
					rules		= function(p_tid,opt)	return os.execute("/usr/sbin/tgtadm --lld iscsi --mode target --op bind --tid "..p_tid.." -I "..opt); 									end, 					--ALLOW CLIENT IP
					unrul		= function(p_tid,opt)	return os.execute("/usr/sbin/tgtadm --lld iscsi --mode target --op unbind --tid "..p_tid.." -I "..opt); 								end,
					used		= function(p_tgt) 		local fd; 																																---
								  fd = io.popen("/usr/sbin/tgtadm --lld iscsi --op show --mode target | /usr/bin/grep --color \"Target [0-9]:\" | /usr/bin/grep "..p_tgt);						---
								  return (#fd:read("a*") > 0);																																	end
					};																																											---
		nsboot.cmd.lun = 	{																																									---
							add		= function(p_tid,p_lun,p_dev) print("FUNC: ","/usr/sbin/tgtadm --lld iscsi --op new --mode logicalunit --tid "..p_tid.." --lun "..p_lun.." -b "..p_dev); return os.execute("/usr/sbin/tgtadm --lld iscsi --op new --mode logicalunit --tid "..p_tid.." --lun "..p_lun.." -b "..p_dev); end,
							del 	= function(p_tid,p_lun) return os.execute("/usr/sbin/tgtadm --lld iscsi --op delete --mode logicalunit --tid "..p_tid.." --lun "..p_lun);					end
					};																																											---
		nsboot.cmd.nbd = 	{																																									---
							mod 	= function(p_max_part,p_nbds) return os.execute("/usr/sbin/modprobe nbd max_part "..p_max_part.." nbds "..p_nbds); 											end,
							unmod 	= function() return os.execute("/usr/sbin/modprobe -r nbd"); 																								end,
							add 	= function(p_dev,p_path,p_flags) return os.execute("/usr/bin/qemu-nbd -c "..p_dev.." "..p_path.." "..p_flags);												end,
							del 	= function(p_dev) return os.execute("/usr/bin/qemu-nbd -d "..p_dev); 																						end,
							used	= function(p_dev) local fd; fd = io.popen("/usr/bin/lsof -t "..p_dev.." 2>/dev/nul "); return (#fd:read("a*") > 0); end,
							usewho	= function(p_dev) local fd; fd = io.popen("/usr/bin/lsof -t "..p_dev.." | /usr/bin/grep \"$(/usr/bin/pgrep qemu-nbd)\"  2>/dev/null");							---
																if fd ~= nil and (#fd:read("a*") > 0) then return 1 end; fd:close();															---
																fd = io.popen("/usr/bin/lsof -t "..p_dev.." | /usr/bin/grep \"$(/usr/bin/pgrep tgtd)\" 2>/dev/null");								---
																if fd ~= nil and (#fd:read("a*") > 0) then return 2 end; fd:close();															end
					};
		nsboot.cmd.img = 	{
							new 	= function(p_path,p_size) 
									return os.execute("/usr/bin/qemu-img -f qcow2 -o preallocation=metadata,compat=1.1,lazy_refcounts=on encryption=off "..p_path.." "..p_size);				end,
							child 	= function(p_parrent,p_child) 
									return os.execute("/usr/bin/qemu-img create -f qcow2 -b "..p_parrent.." "..p_child.." -o lazy_refcounts=on ");					end,
							del 	= function(p_image) return os.remove(p_image); 																												end,
							used 	= function(p_image) local fd; fd = io.popen("/usr/bin/lsof -t "..p_image.." 2>/dev/null"); return (#fd:read("a*") > 0); 									end;
					};



	--[[===========================================================================================================================================================================================]]
	--[[ TARGET COMMANDS sets opt1,opt2,opt3  ]]
	--[[===========================================================================================================================================================================================]]
	    nsboot.inc.checkconf = function(p_test) 
	    	local result = true
				if	nsboot.cfg 						== nil then result=false end
				if  nsboot.cfg ~= nil then
				if	nsboot.cfg.server 				== nil then result=false end
				if	nsboot.cfg.iscsi 				== nil then result=false end
				if	nsboot.cfg.iscsi.iqn 			== nil then result=false end
				if	nsboot.cfg.iscsi.listen 		== nil then result=false end
				if	nsboot.cfg.iscsi.port 			== nil then result=false end
				if	nsboot.cfg.iscsi.proto			== nil then result=false end
				if	nsboot.cfg.dhcp 				== nil then result=false end
				if	nsboot.cfg.dhcp.config			== nil then result=false end
				if	nsboot.cfg.dhcp.config.global	== nil then result=false end
				if	nsboot.cfg.server.vendor 		== nil then result=false end
				if	nsboot.cfg.server.version		== nil then result=false end
				if	nsboot.cfg.server.ipv4			== nil then result=false end
				if	nsboot.cfg.server.mask			== nil then result=false end
				if	nsboot.cfg.server.gateway		== nil then result=false end
				if	nsboot.cfg.server.dns1			== nil then result=false end
				if	nsboot.cfg.server.dns2			== nil then result=false end
				if	nsboot.cfg.server.workdir		== nil then result=false end
				if	nsboot.cfg.server.tftp			== nil then result=false end
				if	nsboot.cfg.server.distdir		== nil then result=false end
				if	nsboot.cfg.server.imgdir		== nil then result=false end
				if	nsboot.cfg.server.imgdatadir	== nil then result=false end
				if	nsboot.cfg.server.imgbackdir	== nil then result=false end
				if	nsboot.cfg.server.config		== nil then result=false end
				if  nsboot.cfg.wks 					== nil then result=false end
				if	nsboot.cfg.dhcp.port 			== nil then result=false end
				if	nsboot.cfg.dhcp.workdir			== nil then result=false end
				if	nsboot.cfg.tftp.port 			== nil then result=false end
				if  nsboot.cfg.tftp.workdir			== nil then result=false end
				if  nsboot.cfg.server.image_prefix  == nil then result=false end
				if  nsboot.cfg.server.nbd_nbds 		== nil then result=false end
				if  nsboot.cfg.server.nbd_max_part  == nil then result=false end
				end
					return result
		end;			
		nsboot.inc.lsof = function(p_patern)
							local fd; fd = io.popen("/usr/bin/lsof "..p_patern.." 2>/dev/null");
							return (#fd:read("a*") > 0 )
		end;
		nsboot.inc.lsofkill = function(p_path)
							if tostring(nsboot.cfg.server.debug) == "1" then print("/usr/bin/kill -9 $(/usr/bin/lsof -t "..p_path.." ) ") end
							return os.execute("/usr/bin/kill -9 $( /usr/bin/lsof -t "..p_path.." ) 2>/dev/null");
							 
		end;
		nsboot.inc.scCheck	= function()
				local result = true
				if nsboot.inc.checkconf then
					if not nsboot.inc.lsof("-t -i:"..nsboot.cfg.dhcp.port) then result=false 	end
					if not nsboot.inc.lsof("-t -i:"..nsboot.cfg.tftp.port) then result=false 	end
					if not nsboot.inc.lsof("-t -i:"..nsboot.cfg.iscsi.port) then result=false	end
				end
				return result
		end;
		nsboot.inc.systemctl = function(p_name,p_cmd)
						return os.execute("/usr/bin/systemctl "..p_cmd.." "..p_name)
		end;
		nsboot.inc.monit = function()
					if not nsboot.inc.lsof("-t -i:"..nsboot.cfg.dhcp.port) 	then nsboot.inc.systemctl("isc-dhcp-server","start"); nsboot.inc.systemctl("isc-dhcp-server","restart");	end;
					if not nsboot.inc.lsof("-t -i:"..nsboot.cfg.tftp.port) 	then nsboot.inc.systemctl("isc-dhcp-server","start"); nsboot.inc.systemctl("tftpd-hpa","restart");	end;
					if not nsboot.inc.lsof("-t -i:"..nsboot.cfg.iscsi.port) then nsboot.inc.systemctl("isc-dhcp-server","start"); nsboot.inc.systemctl("tgt","restart");	end;
		end;
		nsboot.inc.GetMacFromIPv4 = function(p_ipv4)
			if nsboot.inc.checkconf() and p_ipv4 ~= nil then
				local i,v
					for i,v in pairs(nsboot.cfg.wks) do
						if p_ipv4 == v.ipv4 then if v.mac ~= nil then return v.mac; end; end;
					end;
				i,v = nil,nil
			end;
		end;
		nsboot.inc.GetIDFromIPv4 = function(p_ipv4)
			if nsboot.inc.checkconf() and p_ipv4 ~= nil then
				local i,v
					for i,v in pairs(nsboot.cfg.wks) do
						if p_ipv4 == v.ipv4 then  return i; end;
					end;
				i,v = nil,nil
			end;
		end;
	

	function nsboot.inc.isDir(name)
		local lfs = require("lfs")
	    if type(name)~="string" then return false end
	    local cd = lfs.currentdir()
	    local is = lfs.chdir(name) and true or false
	    lfs.chdir(cd)
	    return is
	end;
	function nsboot.inc.isFile(name)
	    if type(name)~="string" then return false end
	    if not nsboot.inc.isDir(name) then
	        return os.rename(name,name) and true or false
	        -- note that the short evaluation is to
	        -- return false instead of a possible nil
	    end
	    return false
	end;

	function nsboot.inc.isFileOrDir(name)
	    if type(name)~="string" then return false end
	    return os.rename(name, name) and true or false
	end	

	--[[ TARGET COMMANDS sets opt1,opt2,opt3  ]]
	--[[===========================================================================================================================================================================================]]

			function nsboot:SaveToFile(fpath, t_data)
				if nsboot.inc.checkconf() then
					local json,result,file = require("json");
					file = io.open(fpath, "w");
					result = json.encode(t_data)
					file:write(result);
					file:close()
					return true
				else
					return false
				end
			end;
			function nsboot:LoadFromFile(fpath)
				local l_data,l_result,file = {};
				file = io.open(fpath, "r");
				l_result = file:read("*a");
				l_data = json.decode(l_result)
				file:close()
				return l_data
			end;
			function nsboot:ExportDHCP()
				if nsboot.inc.checkconf() then
					-- if isDir(nsboot.cfg.dhcp.workdir) and isFile(nsboot.cfg.dhcp.workdir.."/dhcpd.conf") then
						os.rename(nsboot.cfg.dhcp.workdir.."/dhcpd.conf",nsboot.cfg.dhcp.workdir.."/dhcpd.conf.backup_"..os.date("%D%T"):gsub('%W',''));
						local file,data,i,v = io.open(nsboot.cfg.dhcp.workdir.."/dhcpd.conf", "w") ;
							file:write("## ### THIS FILE AUTOGEENERATION ### #\n");
							file:write("# ### "..nsboot.cfg.server.vendor.." "..nsboot.cfg.server.version.."______  ### #\n");
							file:write("#[============================================================================================]#\n");
						for i,v in pairs(nsboot.cfg.dhcp.config.global) do
							file:write(i," ",tostring(v)..";\n"); 
						end;
						file:write("#[============================================================================================]#\n");
						i,v = nil,nil
						for i,v in pairs(nsboot.cfg.dhcp.config.opt) do
							if i == 'domain-name' then file:write("	option "..i," \"",tostring(v).."\";\n"); else file:write("	option "..i," ",tostring(v)..";\n"); end;
						end;
						file:write("#[============================================================================================]#\n");
						i,v = nil,nil
						for i,v in ipairs(nsboot.cfg.dhcp.config.sub) do
							file:write("	subnet ",v.sub," netmask ",v.mask," {\n");
								local k,val 
								for k,val in ipairs(v.ranges) do
									file:write("            range ",val,";\n");
								end;
								k,val = nil,nil;
								file:write("}\n");	
						end;
						file:write("#[============================================================================================]#\n");
						file:write(nsboot.cfg.dhcp.config.ipxe, "\n");
						file:write("#[============================================================================================]#\n");
						i,v = nil,nil
							for i,v in pairs(nsboot.cfg.wks) do
								if v.name ~= nil then
								 if tostring(v.enable) == "1" then
									file:write("host ",v.name," {\n");
									file:write("	hardware ethernet ",v.mac," ;\n");
											file:write("	fixed-address ",v.ipv4,";\n");
											file:write("	option host-name \"",v.name,"\";\n");
											file:write("	if substring (option vendor-class-identifier, 15, 5) = \"00000\" {\n");
											file:write("		filename \"",v.fileboot,".kpxe\";\n"); 
											file:write("	}\n");
											file:write("	elsif substring (option vendor-class-identifier, 15, 5) = \"00006\" {\n");
											file:write("		filename \"",v.fileboot,"32.efi\";\n"); 
											file:write("	}\n");
											file:write("	else {\n");
											file:write("		filename \"",v.fileboot,".efi\";\n"); 
											file:write("	}\n");

								 end;
								local k,val 
									for k,val in ipairs(v.opt) do
										file:write("option	",val,";\n");
									end;
										file:write("}\n");
								end;

								 k,val = nil,nil
							end;														
							file:close();
						i,v = nil,nil
					-- end;
				end;
			end;   		
		
	--[[ TARGET COMMANDS sets opt1,opt2,opt3  ]]
	--[[===========================================================================================================================================================================================]]
		function nsboot:tgtstart(p_ip)
			nsboot.inc.monit()
			if nsboot.inc.scCheck() and nsboot.inc.checkconf() then
					local l_id = nsboot.inc.GetIDFromIPv4(p_ip);
						if tostring(nsboot.cfg.server.debug) == "1" then print(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W',''),nsboot.cfg.wks[l_id].tid); print(nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W',''))); end;
						if not nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','')) and tostring(nsboot.cfg.wks[l_id].enable) == "1" then nsboot.cmd.tgt.new(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W',''),nsboot.cfg.wks[l_id].tid); nsboot.cmd.tgt.rules(nsboot.cfg.wks[l_id].tid,p_ip); end;
						if tostring(nsboot.cfg.server.debug) == "1" then 	print("STARTED !"); print(nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W',''))); end;
			end;
		end;
		function nsboot:tgtstop(p_ip)
			nsboot.inc.monit()
			if nsboot.inc.scCheck() and nsboot.inc.checkconf() then
					local l_id = nsboot.inc.GetIDFromIPv4(p_ip);
						if tostring(nsboot.cfg.server.debug) == "1" then print (nsboot.cfg.wks[l_id].tid); print(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','')); print(nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W',''))); end;
						-- if 
						if nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','')) then nsboot.cmd.tgt.kill(nsboot.cfg.wks[l_id].tid); end;
						if tostring(nsboot.cfg.server.debug) == "1" then print(nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W',''))); end;
			end;
		end;
	--[[===========================================================================================================================================================================================]]
		function nsboot:mkChild(p_ip)
			local l_id,i,v,img_bpath,img_ppath = nsboot.inc.GetIDFromIPv4(p_ip);
			if nsboot.cfg.wks[l_id].img ~= nil then
				for i,v in pairs(nsboot.cfg.wks[l_id].img) do	
					if nsboot.inc.checkconf() and v.path ~= nil and v.type == "dyndisk" and tostring(v.enable) == "1" then
						img_bpath,img_ppath = nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W',''), nsboot.cfg.server.imgdir.."/"..v.path;
					elseif nsboot.inc.checkconf() and v.path ~= nil and v.type == "dyndata" and tostring(v.enable) == "1" then
						img_bpath,img_ppath = nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W',''), nsboot.cfg.server.imgdatadir.."/"..v.path;
					end;
					if img_ppath  then
						if nsboot.inc.isFile(img_bpath) then
							while nsboot.cmd.img.used(img_bpath) do
								nsboot.inc.lsofkill(img_bpath)
								require("posix.unistd").sleep(1);
							end;
							nsboot.cmd.img.del(img_bpath);
							end;
							if not nsboot.inc.isFile(img_bpath) and nsboot.inc.isFile(img_ppath) then
								nsboot.cmd.img.child(img_ppath,img_bpath)
							else
								return "ERROR CREATE CHILD"
							end;
					end;
					img_ppath = nil;
				end;
			end;			
			l_id,i,v = nil,nil,nil;
		end;
		function nsboot:rmChild(p_ip)

			local l_id,i,v,img_bpath,img_ppath = nsboot.inc.GetIDFromIPv4(p_ip);
			if nsboot.cfg.wks[l_id].img ~=nil then
				for i,v in pairs(nsboot.cfg.wks[l_id].img) do
					print(nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W',''))
					if nsboot.inc.checkconf() and v.path ~= nil and v.type == "dyndisk" and tostring(v.enable) == "1" then
						img_bpath,img_ppath = nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W',''), nsboot.cfg.server.imgdir.."/"..v.path;
					elseif nsboot.inc.checkconf() and v.path ~= nil and v.type == "dyndata" and tostring(v.enable) == "1" then
						img_bpath,img_ppath = nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W',''), nsboot.cfg.server.imgdatadir.."/"..v.path;
					end;
					if img_ppath  then
						if nsboot.inc.isFile(img_bpath) then
							while nsboot.cmd.img.used(img_bpath) do
								nsboot.inc.lsofkill(img_bpath)
								require("posix.unistd").sleep(1);
							end;
							nsboot.cmd.img.del(img_bpath);
						end;
					end;
					img_ppath = nil;
				end;
			end;				
		end;
	--[[===========================================================================================================================================================================================]]
		function nsboot:nbdFree(p_ip)
				local l_id,i,v = nsboot.inc.GetIDFromIPv4(p_ip);
			if nsboot.cfg.wks[l_id].img ~=nil then
				for i,v in pairs(nsboot.cfg.wks[l_id].img) do
					while nsboot.cmd.nbd.used(v.nbd) do
							if tostring(nsboot.cfg.server.debug) == "1" then io.write("blocked: "); print(nsboot.cmd.nbd.usewho(v.nbd)); end;
							if nsboot.cmd.nbd.usewho(v.nbd) == 2 then 
								while nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','')) do 
									nsboot:tgtstop(p_ip); 
									require("posix.unistd").sleep(1);
								end
							elseif  nsboot.cmd.nbd.usewho(v.nbd) == 1 then 
								if tostring(nsboot.cfg.server.debug) == "1" then io.write("remove: "); print(v.nbd); end;
								nsboot.cmd.nbd.del(v.nbd);
								--nsboot.inc.lsofkill(v.nbd)
								nsboot.cmd.nbd.del(v.nbd); 
							end;
							require("posix.unistd").sleep(1);
							
					end;
				end;
			end;
			l_id,i,v = nil,nil,nil;
		end;
		function nsboot:nbdConnect(p_ip)
			local l_id,i,v = nsboot.inc.GetIDFromIPv4(p_ip);
			if l_id ~= nil and nsboot.cfg.wks[l_id].img ~=nil then
				for i,v in pairs(nsboot.cfg.wks[l_id].img) do
					while nsboot.cmd.nbd.used(v.nbd) do
							if tostring(nsboot.cfg.server.debug) == "1" then io.write("blocked: "); print(nsboot.cmd.nbd.usewho(v.nbd)); end;
							if nsboot.cmd.nbd.usewho(v.nbd) == 2 then 
								while nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','')) do 
									nsboot:tgtstop(p_ip); 
									require("posix.unistd").sleep(1);
								end
							elseif  nsboot.cmd.nbd.usewho(v.nbd) == 1 then 
								nsboot.cmd.nbd.del(v.nbd); 
							end;
							require("posix.unistd").sleep(1);
					end;
					while nsboot.cmd.nbd.used(v.nbd) do
						require("posix.unistd").sleep(1);
					end
					if not nsboot.cmd.nbd.used(v.nbd) then
						if tostring(nsboot.cfg.server.debug) == "1" then io.write("unblocked: "); print(v.nbd); end;
						if v.path ~= nil and tostring(v.enable) == "1" then
							if tostring(v.enable) == "1"  and v.type == "dyndisk" or v.type == "dyndata" then
								nsboot.cmd.nbd.add(v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W','')," --discard=unmap --cache="..v.cache)			
							end;
						end;
					end;					
				end;
			end;
			l_id,i,v = nil,nil,nil;
		end;
		function nsboot:LunAdd(p_ip)
			local l_id,i,v = nsboot.inc.GetIDFromIPv4(p_ip);
				if nsboot.inc.checkconf() then
					while not nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','')) do
						nsboot:tgtstart(p_ip)
						require("posix.unistd").sleep(1);
					end;
					if nsboot.cmd.tgt.used(nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','')) then

						for i,v in ipairs(nsboot.cfg.wks[l_id].img) do
								if tostring(nsboot.cfg.server.debug) == "1" then print(v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W','')); end;
								if tostring(v.enable) == "1" and v.type == "dyndisk" and nsboot.cfg.wks[l_id].tid ~= nil and nsboot.inc.isFile(v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W','')) then
								if tostring(nsboot.cfg.server.debug) == "1" then print(nsboot.cfg.wks[l_id].tid); end;
									if tostring(nsboot.cfg.server.debug) == "1" then print("ADD 1:  :  : NUM:",nsboot.cfg.wks[l_id].tid,i,v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W','')); end;
									nsboot.cmd.lun.add(nsboot.cfg.wks[l_id].tid,i,v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W',''))
								end;
								if tostring(v.enable) == "1" and v.type == "dyndata" and nsboot.cfg.wks[l_id].tid ~= nil and nsboot.inc.isFile(v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W','')) then
									if tostring(nsboot.cfg.server.debug) == "1" then print("ADD 1:  :  : NUM:",nsboot.cfg.wks[l_id].tid,i,v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W','')); end;
									nsboot.cmd.lun.add(nsboot.cfg.wks[l_id].tid,i,v.nbd,nsboot.cfg.server.imgbackdir.."/"..v.path..nsboot.cfg.server.image_prefix..nsboot.cfg.wks[l_id].mac:gsub('%W',''))
								end;

						end;
					end;					
				end;
		end;


	--[[===========================================================================================================================================================================================]]		
--return nsboot
		function nsboot:GetPage()
			nsboot.inc.monit()
			if nsboot.inc.checkconf() then
				if ngx.var.arg_getmebootargs == ngx.var.remote_addr and ngx.var.remote_addr ~= "::1"  then
					local l_id = nsboot.inc.GetIDFromIPv4(ngx.var.remote_addr);
					ngx.say("#!ipxe\n");
					ngx.say("set  initiator-iqn "..nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','').."\n");
					ngx.say("set  root-path iscsi:${next-server}:"..nsboot.cfg.iscsi.proto..":"..nsboot.cfg.iscsi.port..":1:"..nsboot.cfg.iscsi.iqn..":"..nsboot.cfg.wks[l_id].mac:gsub('%W','').."\n");
					ngx.say(nsboot.cfg.web.pages.ipxe.body:gsub("([\n])", '\n'));
					ngx.say(nsboot.cfg.web.pages.ipxe.footer:gsub("([\n])", '\n'));
					if  tostring(nsboot.cfg.wks[l_id].supper) == "1"  then
					else
						nsboot:tgtstop(ngx.var.remote_addr);
						nsboot:nbdFree(ngx.var.remote_addr);
						nsboot:mkChild(ngx.var.remote_addr);
						nsboot:nbdConnect(ngx.var.remote_addr);
						nsboot:LunAdd(ngx.var.remote_addr);
					end;
									-- nsboot:nbdFree("192.168.0.4");
									-- nsboot:mkChild("192.168.0.4");
									-- nsboot:nbdConnect("192.168.0.4")
									-- nsboot:LunAdd("192.168.0.4");					
									--ngx.say("#!ipxe\n:start\necho Boot menu\nmenu Selection\necho \"MY SHELL\"\nshell\n");
			    else
					-- nsboot:ExportDHCP();			
						-- nsboot:nbdFree("192.168.0.4");
						-- nsboot:mkChild("192.168.0.4");
						-- nsboot:nbdConnect("192.168.0.4");
						-- nsboot:LunAdd("192.168.0.4");
					-- nsboot.inc.GetIDFromIPv4("192.168.0.3")
					-- nsboot:nbdFree("192.168.0.3")
					-- nsboot:tgtstop("192.168.0.3")
					-- nsboot:rmChild("192.168.0.3");					
				end;
			end;
		end;
	--[[===========================================================================================================================================================================================]]

		nsboot:GetPage()
