# A script block which can be implemented using Invoke-Command -Session $session aimed at retrieving WDS implemented printer listings and resolving their respective names from the WDS id format

$enumeratePrintersScriptBlock = {
    $printerConnectionsComObject = (New-Object -ComObject WScript.Network).EnumPrinterConnections()
    $printerConnections = @()

    for ($i = 0; $i -lt $printerConnectionsComObject.Count(); $i++) {
        $printerConnections += $printerConnectionsComObject.Item($i)
    }

    for ($i = 0; $i -lt $printerConnections.Count; $i += 2) {
        $portName = $printerConnections[$i]
        $printerName = $printerConnections[$i+1]

        if ($portName -match "WSD") {
            $wsdPrinter = Get-WmiObject -Query "SELECT * FROM Win32_Printer WHERE Name = '$printerName'"
            $wsdPrinterName = $wsdPrinter.Name
            Write-Host "[WSD Name] $wsdPrinterName"
        }
        else {
            Write-Host "$portName"
        }
    }
}
