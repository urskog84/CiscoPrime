function Get-PrimeConfigFile{
    Param(
        [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credential')]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]$Credential,
        [Parameter(Mandatory = $true, Position = 1, HelpMessage ='Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]$Hostname,
        [Parameter(Mandatory = $false,Position = 2,HelpMessage = 'fileID')]
        [ValidateNotNullorEmpty()]
        [String]$fileID
    )
    Process {
        $Headers = Get-BasicAuthorization -Credential $Credential
        $UriAdress =  BuildURL -Hostname $Hostname -CallURL "/op/configArchiveService/extractSanitizedFile.json?fileId=$fileID"
        $UriAdress
        $Response =  Invoke-WebRequest -Uri $UriAdress -Method get -Body $xmlPost -Headers $Headers -ContentType "text/xml" -DisableKeepAlive
        $Response = $Response.Content | ConvertFrom-Json
        return $Response.mgmtResponse.extractFileResult.fileData
    }
}
