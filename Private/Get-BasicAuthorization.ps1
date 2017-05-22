Function Get-BasicAuthorization {
    Param(
        [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Credentials')]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]$Credential
    )
Process {
        $basicAuthValue = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Credential.GetNetworkCredential().UserName,$Credential.GetNetworkCredential().Password)))
        $basicAuthValue = "Basic "+$basicAuthValue
        $headers = @{ Authorization = $basicAuthValue }
        return $headers
    }
}