#Search for HTML elements on a website
function Get-HtmlElement {
    param(
    [Parameter(mandatory=$false, ValueFromPipeline=$false)][string] $Uri,
    [Parameter(mandatory=$false, ValueFromPipeline=$true)] $InvokedWebsite,
    [Parameter(mandatory=$true)][string] $HtmlAttribute,
    [Parameter(mandatory=$true)][string] $HtmlAttributeValue   
    )
    # If uri is used, create website request
    if ($uri){
        $website = Invoke-WebRequest $uri
    } else {
        #If user have made web request in advance
        $website = $InvokedWebsite 
    }
    #Get all HTML elements and search through them all to find a match
    return (($website).Allelements |  Where $HtmlAttribute -like "*$HtmlAttributeValue*")

}


#Get text between two words/text
function Get-TextBetween {
param(
    [Parameter(mandatory=$true, ValueFromPipeline=$true)][string] $Text,
    [Parameter(mandatory=$true)][string] $From,
    [Parameter(mandatory=$true)][string] $To   
    )
    #Use regex to get text between two pieces of string
    $GetText = $Text -Match "$From(.*?)$To"
    return $Matches[1].Trim()

}


#Extract version number from string
function Get-VersionNumber {
    param(
    [Parameter(mandatory=$true, ValueFromPipeline=$true)][string]$Text
    )
    #Use regex to match a version number
    $CheckForVersionNumber = $Text -Match "[0-9]+(\.[0-9]+)*"
    return $Matches[0].Trim()

}

#Export functions
export-modulemember -function Get-HtmlElement,Get-VersionNumber,Get-TextBetween