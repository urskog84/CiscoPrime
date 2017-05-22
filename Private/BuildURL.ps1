Function BuildURL {
    Param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]$Hostname,
        [Parameter(Mandatory = $true, Position = 1, HelpMessage = 'Call part of url')]
        [ValidateNotNullOrEmpty()]
        [string]$CallURL
    )
    Process {
        $uri = "https://" + $Hostname + "/webacs/api/v1" + $CallURL
        return $uri
    }
}