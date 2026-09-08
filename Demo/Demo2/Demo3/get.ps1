get-process | sort-object -property WS -Descending | select-object  id, processname | Format-table
get-service | where-object {$_.StartType -eq "automatic"} | select-object -first 10 name, DisplayName, Status, StartType | Format-table -autosize
$PSVersionTable.PSVersion | Format-List
get-childitem -filter "*.log" -File | Format-table -AutoSize
get-childitem | Format-table -AutoSize