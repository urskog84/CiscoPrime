function Get-PrimeDeviceConfigsVersions{
    Param(
        [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credential')]
        [ValidateNotNullorEmpty()]
        [Parameter(Mandatory = $true, Position = 1, HelpMessage ='Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]$Hostname,
        [System.Management.Automation.PSCredential]$Credential,
        [Parameter(Mandatory = $false,Position = 2,HelpMessage = 'name')]
        [ValidateNotNullorEmpty()]
        [String]$name,
        [Parameter(Mandatory = $false,Position = 3,HelpMessage = 'id')]
        [ValidateNotNullorEmpty()]
        [String]$id
    )
 Process {
    $Headers = Get-BasicAuthorization -Credential $Credential
    if($name)
        {
        $UriAdress =  BuildURL -Hostname $Hostname -CallURL "/data/ConfigVersions?deviceName=contains(`"$name`")"
        }
    [xml]$Respones = Invoke-WebRequest -Uri $UriAdress -Method get -Body $xmlPost -Headers $Headers -ContentType "text/xml" -DisableKeepAlive
    $ConfigVersions = ($Respones.queryResponse.entityId)."#text"
    $Return = @()
    Foreach ($ConfigVersion in $ConfigVersions)
        {
        sleep -Milliseconds 50
        $UriAdress2 =  BuildURL -Hostname $Hostname -CallURL "/data/ConfigVersions/$ConfigVersion.json"
        $Respones2 = Invoke-WebRequest -Uri $UriAdress2 -Method get -Body $xmlPost -Headers $Headers -ContentType "text/xml" -DisableKeepAlive
        $data = ($Respones2.Content | ConvertFrom-Json).queryResponse.entity.configVersionsDTO.fileInfos

        $Return += $data.fileInfo
        }
    return $Return
    }
    }
