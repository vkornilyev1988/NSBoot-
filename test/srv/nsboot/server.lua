#!/usr/bin/lua


-- local socket = require("socket")
-- socket.unix = require"socket.unix"
-- local server = assert(socket.bind("*", 51515))
-- local tcp = assert(socket.tcp())


-- function testpid (p_input)
-- local posix = require "posix"
-- local pid = posix.fork()

-- if pid == 0 then 
--   -- this is the child process
--   print(posix.getpid('pid') .. ": child process")
-- 	if p_input ~= nil and os.execute(p_input) then return "true\n" else return "false\n" end
-- else 
--   -- this is the parent process
--   print(posix.getpid('pid') .. ": parent process")

--   -- wait for the child process to finish
--   posix.wait(pid) 

-- end
-- end;

-- print(socket._VERSION)
-- print(tcp)

-- while 1 do

--   local client = server:accept()

--   line = client:receive()
--   print(line)
--   testpid(line)
-- 	client:send("RESULT: ")
  
--   client:close();

-- end
local posix = require "posix"
local SOCKET="/tmp/socket_nsboot"
-- Server code
function StartServerSocket()
	local libsocket = require "socket"
	local libunix = require "socket.unix"
	local socket = assert(libunix())

	assert(socket:bind(SOCKET))
	assert(socket:listen())
	conn = assert(socket:accept())
	while 1 do
	    data=conn:receive()

	   if data ~= nil then
	   	 print(data) 
	-- local pid = posix.fork()
		-- if pid == 0 then 
		   if os.execute(data) then 
		   	print("Got line: " .. data)
		   	conn:send("echo: " .. data .. "\n")
		   else
		   	conn:send("FALSE")
		   end;

		   
		   break
  	conn:close()
   	os.remove(SOCKET)
		else
    conn:close()
   	os.remove(SOCKET)			
		end;
		   
	  		-- print(posix.getpid('pid') .. ": child process")
	-- else 
	--   print(posix.getpid('pid') .. ": parent process")
	-- 	   	conn:send("false fork")
	-- 	   	conn:close()
	--   posix.wait(pid)
	end;


end;

while true do
	io.open("/run/nsbootd.pid", "w"):write(require("posix").getpid().pid):close()
	os.remove(SOCKET)

	StartServerSocket()
	print("RESTART SERVER ....")
end;