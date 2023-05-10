[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false, HelpMessage="The starting IP address to scan (e.g. 192.168.0) excluding 4th octet")]
    [string]$StartIP,
    [Parameter(Mandatory=$false, HelpMessage="The ending IP address to scan (e.g. 192.168.0.255)")]
    [string]$EndIP,
    [Parameter(Mandatory=$false, HelpMessage="Optional. The file to save the output to.")]
    [string]$Outfile,
    [Parameter(Mandatory=$false, HelpMessage="Display this help message.")]
    [switch]$Help
)

if ($Help) {
    Write-Host "Syntax: .\script.ps1 -StartIP <string> -EndIP <string> [-OutputFile <string>] [-Help]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "-StartIP <string>        The starting IP address to scan (e.g. 192.168.0) excluding 4th octet"
    Write-Host "-EndIP <string>          The ending IP address to scan (e.g. 192.168.0.255)"
    Write-Host "-Outfile <string>    Optional. The file to save the output to."
    Write-Host "-Help                    Display this help message."
    exit
}

if (-not $StartIP -or -not $EndIP) {
    Write-Host "Please provide a StartIP and EndIP to scan for live hosts or use -Help menu" -ForegroundColor Red
    exit
}

Write-Host @'
 ______   ____        ____                                                    
/\__  _\ /\  _`\     /\  _`\                                                  
\/_/\ \/ \ \ \L\ \   \ \,\L\_\    ___     __      ___     ___      __   _ __  
   \ \ \  \ \ ,__/    \/_\__ \   /'___\ /'__`\  /' _ `\ /' _ `\  /'__`\/\`'__\
    \_\ \__\ \ \/       /\ \L\ \/\ \__//\ \L\.\_/\ \/\ \/\ \/\ \/\  __/\ \ \/ 
    /\_____\\ \_\       \ `\____\ \____\ \__/.\_\ \_\ \_\ \_\ \_\ \____\\ \_\ 
    \/_____/ \/_/        \/_____/\/____/\/__/\/_/\/_/\/_/\/_/\/_/\/____/ \/_/ 
                                                                              
                                                                              
'@ -ForegroundColor Yellow

Write-Host "Scanning for live hosts between $StartIP and $EndIP..." -ForegroundColor Green

$ips = 1..($EndIP -split "\.")[-1] | ForEach-Object { "$StartIP.$_" }

$results = foreach ($ip in $ips) {
    $count++
    Write-Progress -Activity "Scanning IP addresses" -Status "Scanned $count out of $($ips.Count)"
    $hostname = $null
    try {
        $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
    }
    catch { }

    if ($hostname) {
        $output = "$ip resolves to $hostname"
        Write-Host $output -ForegroundColor Yellow
if ($Outfile) {
            Add-Content -Path $Outfile -Value $output
        }
    }
}

if ($Outfile) {
    Write-Host "Results saved to $Outfile" -ForegroundColor Green
}
