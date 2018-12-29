--[[

  MQTT/UDP Lua library for NodeMCU. See mqtt_pub.lua and mqtt_sub.lua for usage.

  UNFINISHED!

  See also https://design.goeszen.com/how-to-receive-udp-data-on-nodemcu-lua-esp8266.html
  See also https://nodemcu.readthedocs.io/en/latest/en/modules/net/#netudpsocketlisten

]]

--local mqtt_udp_lib = {}
local mqtt_udp_lib = require "mqtt_proto_lib"

local defs  = require "mqtt_udp_defs"
--local socket = require "socket"
local bit = require "bit"
local mcunet = require "net"

function mqtt_udp_lib.make_listen_socket()

    udp = socket.udp()
    udp:setsockname("*", defs.MQTT_PORT )
    -- udp:settimeout(1)
    udp:settimeout()

    return udp

end

--[[
function mqtt_udp_lib.listen( sock, listener )

while true do
    --data, ip, port = sock:receivefrom()
    data, ip, port = mqtt_udp_lib.recv_packet( sock )
    if data then
        --print("Received: ", data, ip, port, type(data))
        --print("Received from: ", ip, port )
        --[[udp:sendto(data, ip, port)--]]
        topic,val = mqtt_udp_lib.parse_packet(data)
        listener( "publish", topic, val, ip, port );
    end
    socket.sleep(0.01)
end

end
]]

function mqtt_udp_lib.make_publish_socket()

    udp = socket.udp()

    assert(udp)
    --assert(udp:settimeout(1))
    assert(udp:settimeout())
    assert(udp:setoption('broadcast', true))
    assert(udp:setoption('dontroute',true))
    --assert(udp:setsockname(s_address, defs.MQTT_PORT))
    --assert(udp:setsockname("*", defs.MQTT_PORT ))

    return udp

end


--function mqtt_udp_lib.send_packet( data )
--    udp:sendto( data, "255.255.255.255", defs.MQTT_PORT )
--end

function mqtt_udp_lib.send_packet( socket, data )
    socket:sendto( data, "255.255.255.255", defs.MQTT_PORT )
end

function mqtt_udp_lib.recv_packet( socket )
    --data, ip, port = socket:receivefrom()
    return socket:receivefrom()
end

--[[
function mqtt_udp_lib.publish( socket, topic, value )
    data = mqtt_udp_lib.make_packet( topic, value )
    mqtt_udp_lib.send_packet( socket, data )
end
]]

return mqtt_udp_lib

