Param(

    [Parameter(Mandatory=$true)][string]$File

)

if ([System.IO.Path]::GetExtension($File) -eq ".json"){

    $Groups = (Get-Content -Raw -Path $File | ConvertFrom-JSON).Groups

} elseif ([System.IO.Path]::GetExtension($File) -eq ".csv"){

    $Groups = Import-Csv $File

} else {

    Write-Host "File format not supported"
    Write-Host "Supported file formats : .json, .csv"
    Exit

}

$Password = Read-Host "Insert default password" -AsSecureString

foreach($Group in $Groups){

    New-ADGroup -Name $Group.Name -GroupScope $Group.Scope

}
 