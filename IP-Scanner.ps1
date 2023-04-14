Param(
    [Parameter(Mandatory=$true)]
    [string]$StartIP,
    [Parameter(Mandatory=$true)]
    [string]$EndIP
)

Write-Host @'

### ######      #####   #####     #    #     # #     # ####### ######  
 #  #     #    #     # #     #   # #   ##    # ##    # #       #     # 
 #  #     #    #       #        #   #  # #   # # #   # #       #     # 
 #  ######      #####  #       #     # #  #  # #  #  # #####   ######  
 #  #                # #       ####### #   # # #   # # #       #   #   
 #  #          #     # #     # #     # #    ## #    ## #       #    #  
### #           #####   #####  #     # #     # #     # ####### #     # 
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
