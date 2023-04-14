Param(
    [Parameter(Mandatory=$true)]
    [string]$StartIP,
    [Parameter(Mandatory=$true)]
    [string]$EndIP
)

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

foreach ($ip in $ips) {
    $hostname = $null
    try {
        $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
    }
    catch { }

    if ($hostname) {
        Write-Output "$ip resolves to $hostname"
    }
}
