﻿<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Invoke-PBAPI
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Relative path for the API
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $RelativePath,

        # HTTP method
        [Parameter(Mandatory=$true)]
        [Microsoft.PowerShell.Commands.WebRequestMethod]
        $Method,
        
        # Hashtable of request properties
        [Parameter()]
        [System.Collections.Hashtable]
        $Body
    )

    Process
    {
        Write-Verbose "Building headers from API key"
        $Headers = @{
            'Access-Token' = $PBAPIKey;
        }

        Write-Verbose "Invoking the API"
        try
        {
            $Response = Invoke-RestMethod -Headers $Headers -Method $Method -Uri "$PBAPIUrl$RelativePath" -Body $($Body | ConvertTo-Json) -ContentType 'application/json'
        }
        catch
        {
            throw "API Request failed: $_"
        }

        Write-Verbose "Returning the API response"
        return $Response
    }
}