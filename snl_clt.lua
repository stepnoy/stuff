--Copyright (c) 2014, Wuerfel_21
--All rights reserved.
--
--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:
--
--* Redistributions of source code must retain the above copyright notice, this
--  list of conditions and the following disclaimer.
--
--* Redistributions in binary form must reproduce the above copyright notice,
--  this list of conditions and the following disclaimer in the documentation
--  and/or other materials provided with the distribution.
--
--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
--AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
--IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
--FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
--DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
--SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
--CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
--OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

local component = require("component")
local dispenser = require("dispenser")
local event = require("event")

local function removeService(service, hostname) 
  dispenser.open(9261)
  dispenser.send("broadcast",9261,hostname,service,"removeService")
  local _,_,_,_,_,result,info = event.pull("dispenser",_,_,9261)
  dispenser.close(9261)
  return result, info
end

local function registerService(service, hostname) 
  dispenser.open(9261)
  dispenser.send("broadcast",9261,hostname,service,"registerService")
  local _,_,_,_,_,result,info = event.pull("dispenser",_,_,9261)
  dispenser.close(9261)
  return result, info
end

local function getservice(hostname,service)
  dispenser.open(9261)
  dispenser.send("broadcast",9261,hostname,service)
  local _,_,_,_,_,addr,info = event.pull("dispenser",_,_,9261)
  dispenser.close(9261)
  return addr,info
end

local function getService(service, hostname)
  dispenser.open(9261)
  dispenser.send("broadcast",9261,hostname,service)
  local _,_,_,_,_,addr,info = event.pull("dispenser",_,_,9261)
  dispenser.close(9261)
  return addr,info
end

local function resolveName(name)
  dispenser.open(9261)
  dispenser.send("broadcast",9261,name,nil)
  local _,_,_,_,_,addr,info = event.pull("dispenser",_,_,9261)
  dispenser.close(9261)
  return addr,info
end

local function getName(address)
  dispenser.open(9261)
  dispenser.send("broadcast",9261,address,"resolve")
  local _,_,_,_,_,addr,info = event.pull("dispenser",_,_,9261)
  dispenser.close(9261)
  return addr,info
end


return {getName = getName, resolveName = resolveName, getService = getService, getservice = getservice, registerService = registerService, removeService = removeService}


