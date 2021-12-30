$list = Get-Content "nodelist.txt"
 
foreach($server in $list) {
    knife node delete $server -y
    knife client delete $server -y
}
