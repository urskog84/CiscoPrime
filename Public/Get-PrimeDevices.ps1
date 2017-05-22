Function Get-PrimeDevices {
   Param(
        [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credential')]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]$Credential,
        [Parameter(Mandatory = $true, Position = 1, HelpMessage ='Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]$Hostname
    )
 Process {
    $Headers = Get-BasicAuthorization -Credential $Credential
    $UriAdress = BuildURL -Hostname $Hostname -CallURL "/data/Devices?.full=true&.maxResults=350"
    [xml]$PrimeDevices = Invoke-WebRequest -Uri $UriAdress -Method Get -Headers $Headers -ContentType 'application/xml' -DisableKeepAlive
    return $PrimeDevices.queryResponse.entity.devicesDTO
    }
}