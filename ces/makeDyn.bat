::cp s:\malibu\server\evl\include\evl_entity.h                  evl\include\evl_entity.h
::cp s:\malibu\server\evl\include\evl_MGMT_MGMTobjectmanager.h  evl\include\evl_MGMT_MGMTobjectmanager.h
::cp s:\malibu\server\evl\include\evl_ROUTING_ROUTigmp.h        evl\include\evl_ROUTING_ROUTigmp.h

make -C evl
make -C Engine\snmp\igmp