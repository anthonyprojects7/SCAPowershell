#This script pings a list of computers and checks if the are online or offline. 
$computerlistpath = "C:\users\documents\computers.txt"
$computer = get-content -path $computerlistpath

foreach ($computer in $computers) {
if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
    Write-Host "$computer is online" -ForegroundColor Green
} else{
    write-host "$computer is offline" -ForegroundColor Red
}
}

#This script check the size of files in a folder and list files larger than 10MB.
param(
    [parameter(Mandatory=$true)]
    [string]$folderpath
)
$files = get-childitem -path $folderpath -file -Recurse

foreach ($file in $files) {
    if($file.length -gt 10mb) {
        write-host "File $($file.FullName) is larger than 10MB. Size: $($file.length / 1MB) MB"
    }
}

#This script takes a username and retrieves the user's information from Active Directory. 
param(
    [parameter(Mandatory=$true)]
    [string]$username
)
$user = get-aduser -identity $username -properties *
Write-host "display name: $($user.DisplayName)"
write-host "samaccountname: $($user.SamAccountName)"
write-host "email: $($user.mail)"
write-host "enabled: $($user.Enabled)"
write-host "last logon: $($user.LastLogonDate)"

#This script creates a scheduled task to run a PowerShell script at startup.
param(
    [parameter(Mandatory=$true)]
    [string]$scriptpath
)
$action = new-scheduledtaskaction -execute "powershell.exe" -argument "-file `"$scriptpath`""
$trigger = new-scheduledtasktrigger -AtStartup
$taskname = "runpowershellatstartup"

register-scheduledtask -taskname $taskname -action $action -trigger $trigger -runlevel Highest

write-host "scheduled task '$taskname' created to run at startup."

#This script backs up files from "C:\Logs" to "E:\Backups" with today's date as the folder name.
$source = "c:\logs"
$destinationroot = "e:\backups"

$today = get-date -format "yyyy-MM-dd"
$destination = join-path $destinationroot $today

if(!(test-path $destination)) {
    new-item -path $destination -itemtype directory
}

copy-item -path $source\* -destination $destination -Recurse
