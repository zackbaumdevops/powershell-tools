# This function was specifically implemented to interface WinRM Win32_Service objects with a Powershell Core session
# which are typically incompatible with WMI objects commonly utilized in Windows Powershell 5.1. This function shortcuts this issue
# by passing the WmiObject command through as a Base64 string and then executes it within a Windows Powershell 5.1 window
# and can be invoked against a ComputerNames (string array). Calling the service in the typical manner against a remote session
# using Powershell Core is normally impossible due to its inability to remotely call the service's WMI properties.

function Start-WinRMService {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ComputerNames
    )

    foreach ($ComputerName in $ComputerNames) {
        $encodedCommand = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("Get-WmiObject -ComputerName '$ComputerName' -Class Win32_Service -Filter ""Name='winrm'"" | ForEach-Object { `$_.StartService() }"))
        $startProcessArgs = "-NoExit", "-Command", "Invoke-Expression -Command ([System.Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('$encodedCommand')))"

        Start-Process -FilePath "powershell.exe" -ArgumentList $startProcessArgs
    }
}
