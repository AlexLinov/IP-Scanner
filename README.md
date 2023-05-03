# PowerShell IP Scanner

This PowerShell script scans for live hosts between a start and end IP address range. It can output the results to a file and has an option to display the syntax and options.

## Syntax

```powershell
.\script.ps1 -StartIP <string> -EndIP <string> [-Outfile <string>] [-Help]

Parameters
-StartIP <string>: The starting IP address to scan (e.g. 192.168.0) excluding 4th octet. This parameter is mandatory.
-EndIP <string>: The ending IP address to scan (e.g. 192.168.0.255). This parameter is mandatory.
-Outfile <string>: Optional. The file to save the output to.
-Help: Display the help message.

Examples

# Scan for live hosts between 192.168.0.1 and 192.168.0.255 and output results to a file
.\script.ps1 -StartIP 192.168.0 -EndIP 192.168.0.255 -Outfile C:\results.txt

# Display the help message
.\script.ps1 -Help

