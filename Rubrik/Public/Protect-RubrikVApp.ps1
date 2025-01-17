#Requires -Version 3
function Protect-RubrikVApp
{
  <#
      .SYNOPSIS
      Connects to Rubrik and assigns an SLA to a vCD vApp
            
      .DESCRIPTION
      The Protect-RubrikVApp cmdlet will update a vCD vApp's SLA Domain assignment within the Rubrik cluster.
      The SLA Domain contains all policy-driven values needed to protect workloads.
      Note that this function requires the vApp ID value and not the vApp name. This is because vApp names may not be unique across clusters.
      It is suggested that you first use Get-RubrikVApp to narrow down the one or more vApps to protect, and then pipe the results to Protect-RubrikVApp.
      You will be asked to confirm each vApp you wish to protect, or you can use -Confirm:$False to skip confirmation checks.
            
      .NOTES
      Written by Matt Elliott for community usage
      Twitter: @NetworkBrouhaha
      GitHub: shamsway
            
      .LINK
      http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/Protect-RubrikVApp.html
            
      .EXAMPLE
      Get-RubrikVApp "vApp1" | Protect-RubrikVApp -SLA 'Gold'
      This will assign the Gold SLA Domain to any vApp named "vApp1"

      .EXAMPLE
      Get-RubrikVApp "vApp1" -SLA 'Silver' | Protect-RubrikVApp -SLA 'Gold' -Confirm:$False
      This will assign the Gold SLA Domain to any vApp named "vApp1" that is currently assigned to the Silver SLA Domain
      without asking for confirmation
  #>

  [CmdletBinding(SupportsShouldProcess = $true,ConfirmImpact = 'High',DefaultParameterSetName="None")]
  Param(
    # vApp ID
    [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$id,
    # The SLA Domain in Rubrik
    [Parameter(ParameterSetName = 'SLA_Explicit')]
    [String]$SLA,
    # Removes the SLA Domain assignment
    [Parameter(ParameterSetName = 'SLA_Unprotected')]
    [Switch]$DoNotProtect,
    # Inherits the SLA Domain assignment from a parent object
    [Parameter(ParameterSetName = 'SLA_Inherit')]
    [Switch]$Inherit,
    # SLA id value
    [Alias('configuredSlaDomainId')]
    [String]$SLAID = (Test-RubrikSLA -SLA $SLA -Inherit $Inherit -DoNotProtect $DoNotProtect -Mandatory:$true),    
    # Rubrik server IP or FQDN
    [String]$Server = $global:RubrikConnection.server,
    # API version
    [String]$api = $global:RubrikConnection.api
  )

  Begin {

    # The Begin section is used to perform one-time loads of data necessary to carry out the function's purpose
    # If a command needs to be run with each iteration or pipeline input, place it in the Process section
    
    # Check to ensure that a session to the Rubrik cluster exists and load the needed header data for authentication
    Test-RubrikConnection
    
    # API data references the name of the function
    # For convenience, that name is saved here to $function
    $function = $MyInvocation.MyCommand.Name
        
    # Retrieve all of the URI, method, body, query, result, filter, and success details for the API endpoint
    Write-Verbose -Message "Gather API Data for $function"
    $resources = Get-RubrikAPIData -endpoint $function
    Write-Verbose -Message "Load API data for $($resources.Function)"
    Write-Verbose -Message "Description: $($resources.Description)"
  
  }

  Process {
    
    $uri = New-URIString -server $Server -endpoint ($resources.URI) -id $id
    $uri = Test-QueryParam -querykeys ($resources.Query.Keys) -parameters ((Get-Command $function).Parameters.Values) -uri $uri
    $body = New-BodyString -bodykeys ($resources.Body.Keys) -parameters ((Get-Command $function).Parameters.Values)
    $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body
    $result = Test-ReturnFormat -api $api -result $result -location $resources.Result
    $result = Test-FilterObject -filter ($resources.Filter) -result $result

    return $result

  } # End of process
} # End of function