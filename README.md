# IP Scanner

This PowerShell script scans for live hosts between two IP addresses and displays the results on the console.

## Usage

To use this script, run the following command in PowerShell:

```
./IP-Scanner.ps1 -StartIP 192.168.6 -EndIP 192.168.6.255
```

Replace `192.168.6` and `192.168.6.255` with the start and end IP addresses of your network range.

**Note:** The IP addresses should be specified without the last octet.

## Requirements

- PowerShell 5.1 or later

## License

This script is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
