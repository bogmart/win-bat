route delete 10.112.1.3

route delete 10.115.1.2

route delete 10.115.0.0 mask 255.255.0.0 10.2.36.203
route delete 10.116.0.0 mask 255.255.0.0 10.2.36.203

netsh interface ip delete dns "Local Area Connection" 10.112.1.3
