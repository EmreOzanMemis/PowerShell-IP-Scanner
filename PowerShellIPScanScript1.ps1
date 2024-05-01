1..254 | %{ping -n 1 -w 15 192.168.101.$_ | select-string "reply from"}
