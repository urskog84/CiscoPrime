Function Get-PrimeInventoryDetails {
   Param(
        [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credential')]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]$Credential,
        [Parameter(Mandatory = $true, Position = 1, HelpMessage ='Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]$Hostname,
        [Parameter(Mandatory = $true,Position = 2,HelpMessage = 'ID')]
        [ValidateNotNullorEmpty()]
        [String]$id
    )
 Process {
    $Headers = Get-BasicAuthorization -Credential $Credential
    $UriAdress =   BuildURL -Hostname $Hostname -CallURL "/data/InventoryDetails/$id"
    [xml]$PrimeDevices = Invoke-WebRequest -Uri $UriAdress -Method Get -Headers $Headers -ContentType 'application/xml' -DisableKeepAlive
    return $PrimeDevices.queryResponse.entity.inventoryDetailsDTO
    }
}
