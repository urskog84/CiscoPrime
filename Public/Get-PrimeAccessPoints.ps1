Function Get-PrimeAccessPoints {
   Param(
    [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credential')]
    [ValidateNotNullorEmpty()]
    [System.Management.Automation.PSCredential]$Credential,
    [Parameter(Mandatory = $true, Position = 1, HelpMessage ='Hostname')]
    [ValidateNotNullOrEmpty()]
    [String]$Hostname
    )
begin{
$page = 0
}
 Process {
    $Headers = Get-BasicAuthorization -Credential $Credential
    Do{
        $UriAdress = BuildURL -Hostname $Hostname -CallURL "/data/AccessPointDetails?.full=true&.firstResult=$page&.maxResults=100"
        [xml]$PrimeAccessPoints = Invoke-WebRequest -Uri $UriAdress -Method Get -Headers $Headers -ContentType "application/xml" -DisableKeepAlive

        $AllAccessPoint += $PrimeAccessPoints.queryResponse.entity.accessPointDetailsDTO
        $page = $page + 100

    }until($AllAccessPoint.count -ge $PrimeAccessPoints.queryResponse.count)

        return   $AllAccessPoint
    }
}