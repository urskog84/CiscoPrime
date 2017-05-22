function Edit-PrimeAccessPoint{
    Param(
        [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credential')]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]$Credential,
        [Parameter(Mandatory = $true, Position = 1, HelpMessage ='Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]$Hostname,
        [Parameter(Mandatory = $true, Position = 2,HelpMessage = 'name')]
        [ValidateNotNullorEmpty()]
        [String]$name,
        [Parameter(Mandatory = $true,Position = 3,HelpMessage = 'id')]
        [ValidateNotNullorEmpty()]
        [String]$id,
        [Parameter(Mandatory = $true, Position = 4, HelpMessages = 'primaryMwarAddress ex 10.10.4.3')
        [ValidateNotNullorEmpty()]
        [String]$primaryMwarAddress,
        [Parameter(Mandatory = $false, Position = 4, HelpMessages = 'secondaryMwarAddress ex 10.10.4.4')
        [String]$secondaryMwarAddres = "0.0.0.0",
        [Parameter(Mandatory = $false, Position = 4, HelpMessages = 'tertiaryMwarAddress ex 10.10.4.5')
        [String]$tertiaryMwarAddress= "0.0.0.0"
    )
 Process {
    $Headers = Get-BasicAuthorization -Credential $Credential
    $UriAdress = BuildURL -Hostname $Hostname -CallURL "/op/apService/accessPoint"
    
$xmlPost = @"
<accessPoint>
    <accessPointId>$id</accessPointId>
    <adminStatus>true</adminStatus>
        <name>$name</name>
    <unifiedApInfo>
        <primaryMwar>String value</primaryMwar>
        <primaryMwarAddress>
            <address>$primaryMwarAddress</address>
        </primaryMwarAddress>
        <secondaryMwar>String value</secondaryMwar>
        <secondaryMwarAddress>
            <address>$secondaryMwarAddres</address>
        </secondaryMwarAddress>
        <tertiaryMwar>String value</tertiaryMwar>
        <tertiaryMwarAddress>
            <address>$tertiaryMwarAddress</address>
        </tertiaryMwarAddress>
    </unifiedApInfo>
</accessPoint>
"@

    Write-Host $id
    Write-Host $name
    [xml]$EditPrimeAccessPoint = Invoke-WebRequest -Uri $UriAdress -Method Put -Body $xmlPost -Headers $Headers -ContentType "text/xml" -DisableKeepAlive
    return $EditPrimeAccessPoint
    }
    }
