1..255 | foreach-object { (new-object system.net.networkinformation.ping).Send("192.168.101.$_") } | where-object {$_.Status -eq "Success"} | select Address
