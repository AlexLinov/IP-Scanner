# IP Scanner PowerShell Script

This is a PowerShell script that scans for live hosts between two specified IP addresses.

## Prerequisites

- PowerShell v3.0 or higher
- Windows OS or compatible environment

## Usage

To use this script, follow these steps:

1. Open PowerShell console or terminal.
2. Change the directory to the location where the script is saved.
3. Run the script using the following command:

```
.\IPScanner.ps1 -StartIP <string> -EndIP <string> [-OutputFile <string>] [-Help] [-IPListFile file]
```


Replace `<string>` with the desired IP address range and options.

### Parameters

The following parameters are available for this script:

- `-StartIP`: The starting IP address to scan (e.g. 192.168.0) excluding 4th octet. **(required)**
- `-EndIP`: The ending IP address to scan (e.g. 192.168.0.255). **(required)**
- `-OutputFile`: Optional. The file to save the output to.
- `-Help`: Display this help message.
- `-IPListFile`: Take a list of IPs from file.

This example scans for live hosts between IP address 192.168.0.1 and 192.168.0.255 and saves the results to a file named "results.txt" in the "C:\temp" directory.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgments

- This script was inspired by similar scripts found online.



