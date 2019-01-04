package = "mqttudp"

-- TODO somehow get it from defs?
version = "0.3-0"

source = {
   url = "https://github.com/dzavalishin/mqtt_udp"
}

description = {
   summary = "MQTT/UDP implementation in Lua.",
   detailed = [[
      MQTT/UDP is simplest possible UDP broadcast based IoT protocol.
      Lua implementtaion is very basic and is intended to be uses mostly in
      IoT devices. See homepage for more info and other languages.
   ]],
   homepage = "https://github.com/dzavalishin/mqtt_udp", -- All the MQTT/UDP project
}

dependencies = {
   "lua >= 5.1, < 5.4"
   -- If you depend on other rocks, add them here
}

build = {
    type = "builtin",
    modules = {
        proto	= "mqtt_proto_lib.lua",
        udp		= "mqtt_udp_lib.lua",
        defs	= "mqtt_udp_defs.lua",
        pub		= "mqtt_pub.lua",
        sub		= "mqtt_sub.lua",
        node	= "mqtt_udp_lib_NodeMCU.lua",
        wshark	= "wireshark_mqtt_dissector.lua"
    }
}
