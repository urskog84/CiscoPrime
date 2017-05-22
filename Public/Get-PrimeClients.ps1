Function Get-PrimeClients {
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
    Do {
        $UriAdress =   BuildURL -Hostname $Hostname -CallURL "/data/Clients/?.full=true&.firstResult=$page&.maxResults=200"
        [xml]$PrimeClients = Invoke-WebRequest -Uri $UriAdress -Method Get -Headers $Headers -ContentType "application/xml"  -DisableKeepAlive

        $AllPrimeClients += $PrimeClients.queryResponse.entity.ClientsDTO
        $page = $page + 100

    }until ($AllPrimeClients.count -ge $PrimeClients.queryResponse.count)

    return $AllPrimeClients
    }
}
