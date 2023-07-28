[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false, HelpMessage="The starting IP address to scan (e.g. 192.168.0) excluding 4th octet")]
    [string]$StartIP,
    [Parameter(Mandatory=$false, HelpMessage="The ending IP address to scan (e.g. 192.168.0.255)")]
    [string]$EndIP,
    [Parameter(Mandatory=$false, HelpMessage="Optional. The file to save the output to.")]
    [string]$Outfile,
    [Parameter(Mandatory=$false, HelpMessage="Optional. The file containing a list of IP addresses to scan.")]
    [string]$IPListFile,
    [Parameter(Mandatory=$false, HelpMessage="Display this help message.")]
    [switch]$Help
)

[Console]::TreatControlCAsInput = $true

function Cancel-Script {
    Write-Host "Cancellation requested. Script is terminating..." -ForegroundColor Blue
    throw [System.OperationCanceledException]::new("Script execution was canceled.")
}

try {
    if ($Help) {
        Write-Host "Syntax: .\script.ps1 [-StartIP <string> | -EndIP <string>] [-OutputFile <string>] [-IPListFile <string>] [-Help]"
        Write-Host ""
        Write-Host "Options:"
        Write-Host "-StartIP <string>        The starting IP address to scan (e.g. 192.168.0) excluding 4th octet"
        Write-Host "-EndIP <string>          The ending IP address to scan (e.g. 192.168.0.255)"
        Write-Host "-Outfile <string>        Optional. The file to save the output to."
        Write-Host "-IPListFile <string>     Optional. The file containing a list of IP addresses to scan."
        Write-Host "-Help                    Display this help message."
        exit
    }


$ips = @()

if ($IPListFile -and (Test-Path $IPListFile)) {
    $ips = Get-Content $IPListFile
} elseif ($StartIP -and $EndIP) {
    $startip = $StartIP.Split(".")[0..2] -join "."
    $endip = $EndIP
    $ips = 1..255 | ForEach-Object { "$startip.$_" }
}
else {
    Write-Host "Please provide either the -StartIP or the -EndIP parameter." -ForegroundColor Red
    exit
}

    Write-Host @'
 +-+-+ +-+-+-+-+-+-+-+
 |I|P| |S|c|a|n|n|e|r|
 +-+-+ +-+-+-+-+-+-+-+
 by actuaL
'@ -ForegroundColor Yellow

    if ($ips.Count -eq 0) {
        Write-Host "No IP addresses provided. Please use -Help for usage." -ForegroundColor Red
        exit
    }

    Write-Host "Scanning for live hosts..." -ForegroundColor Green

    $count = 0
    $results = foreach ($ip in $ips) {
        if ([Console]::KeyAvailable) {
            $key = [Console]::ReadKey($true)
            if ($key.Key -eq "C" -and ($key.Modifiers -band [ConsoleModifiers]::Control) -ne 0) {
                Cancel-Script
            }
        }

        $count++
        Write-Progress -Activity "Scanning IP addresses" -Status "Scanned $count out of $($ips.Count)"

        # Resolve the IP to hostname
        try {
            $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
        } catch {
            $hostname = $null
        }

        if ($hostname) {
            $output = "$ip resolves to $hostname"
            Write-Host $output -ForegroundColor Yellow
            if ($Outfile) {
                Add-Content -Path $Outfile -Value $output
            }
        } 

        # Sleep a short duration to allow checking for cancellation
        Start-Sleep -Milliseconds 100
    }
    if ($Outfile) {
        Write-Host "Results saved to $Outfile" -ForegroundColor Green
    }
} catch [System.OperationCanceledException] {
    Write-Host "Script canceled. Exiting..." -ForegroundColor Yellow
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
