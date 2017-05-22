Function Get-PrimeClientDetail {
    Param(
        [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credential')]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]$Credential,
        [Parameter(Mandatory = $true, Position = 1, HelpMessage ='Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]$Hostname,
        [parameter(parametersetname="macAddress", mandatory=$false)]
        [String]$macAddress,
        [parameter(parametersetname="ipAdress", mandatory=$false)]
        [String]$ipAdress,
        [parameter(parametersetname="macAddressStart", mandatory=$false)]
        [String]$macAddressStart
    )
 Process {
    $Headers = Get-BasicAuthorization -Credential $Credential
    if($ipAdress){
    $UriAdress =  BuildURL -Hostname $Hostname -CallURL "/data/ClientDetails?ipAddress="+$ipAdress+"&.full=true"
    }
    if($macAddress){
        $start = '"'
        $end = '"'
        $macAddress=$start+$macAddress+$end
        $UriAdress =  BuildURL -Hostname $Hostname -CallURL "/data/ClientDetails?macAddress="+$macAddress+"&.full=true"
    }
    if($macAddressStart){
        $start = '("'
        $end = '")'
        $macAddressStart=$start+$macAddressStart+$end
        $UriAdress =  BuildURL -Hostname $Hostname -CallURL "/data/ClientDetails?macAddress=startsWith"+$macAddressStart+"&.full=true"
    }
    [xml]$PrimeClientDetail = Invoke-WebRequest -Uri $UriAdress -Method Get -Headers $Headers -ContentType "application/xml" -DisableKeepAlive
    return $PrimeClientDetail.queryResponse.entity.clientDetailsDTO
    }
}
