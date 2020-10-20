#!/usr/bin/lua
-- local socket = require("socket")
-- socket.unix = require"socket.unix"
-- local posix = require("posix")
-- local host, port = "127.0.0.1", 51515
-- local tcp = assert(socket.tcp())

-- tcp:connect(host, port);
-- tcp:send(io.read()..'\n');

-- while true do
--     local s, status, partial = tcp:receive()
--     print(s or partial)
--     if status == "closed" then
--       break
--     end
-- end



-- tcp:close()
-- Client code
function GetCommandClient(p_dev,p_path,p_cache)
	local socket = require"socket"
	socket.unix = require"socket.unix"
	local c = assert(socket.unix())
	assert(c:connect("/tmp/socket_nsboot"))
	--c:send(argum1.." "..argum2.."\n")
	--/srv/nsboot/client.lua /usr/bin/qemu-nbd '--connect="..p_dev.." "..p_path.." --pid-file="..p_path..".pid "..p_flags.."'"
	c:send("/usr/bin/qemu-nbd --fork --connect="..p_dev.." "..p_path.." --pid-file="..p_path..".pid --discard=unmap --cache="..p_cache.."\n")
	if data ~= nil then data=assert(c:receive()) print("Got line: " .. data) end                         
	
	c:close();
end;
function isFile(name)
			local posix = require("posix")
	        if name ~= nil and posix.stat(name) ~= nil then return true else return false end;
	        -- note that the short evaluation is to
	        -- return false instead of a possible nil

	    return false
end;

function WaitSocketReady()
	while not  isFile("/tmp/socket_nsboot") do
		require("posix.unistd").sleep(0.5);
	end;
end;
if arg[1] ~= nil and arg[2] ~= nil and arg[3] ~= nil then  WaitSocketReady(); GetCommandClient(arg[1],arg[2],arg[3]) end;