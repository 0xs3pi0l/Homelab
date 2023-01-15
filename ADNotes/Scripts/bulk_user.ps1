Param(

    [Parameter(Mandatory=$true)][string]$File

)

if ([System.IO.Path]::GetExtension($File) -eq ".json"){

    $Users = (Get-Content -Raw -Path $File | ConvertFrom-Json).Users

    } elseif ([System.IO.Path]::GetExtension($File) -eq ".csv") {

        $Users = Import-Csv $File

    } else {

        Write-Host "File format not supported"
        Write-Host "Supported file formats : .json, .csv"
}

$Password = Read-Host "Insert default password" -AsSecureString

foreach ($User in $Users){

    New-ADUser -Name $User.Name -AccountPassword $Password -Enabled $true -Surname $User.Surname -GivenName $User.GivenName -EmailAddress $User.EmailAddress -SamAccountName $User.SamAccountName -DisplayName $User.DisplayName -Country $User.Country -City $User.City -PassThru -ChangePasswordAtLogon $true

}

    


