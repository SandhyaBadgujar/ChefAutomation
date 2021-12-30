## Powershell Script to delete bulk nodes from Chef Server
## This should be run from chef workstation

$list = Get-Content "nodelist.txt"
 
foreach($server in $list) {
    knife node delete $server -y
    knife client delete $server -y
}
