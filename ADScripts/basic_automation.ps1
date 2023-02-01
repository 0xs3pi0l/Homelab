Param(

    [Parameter(Mandatory=$true)][string]$Mode,
    [Parameter(Mandatory=$true)][string]$File

)

if(-not (Test-Path -Path $File -PathType Leaf)){

    Write-Host "File does not exist"
    Exit

}

if ([System.IO.Path]::GetExtension($File) -eq ".json"){

    $Objects = Get-Content -Raw -Path $File | ConvertFrom-JSON

} else {

    Write-Host "File format not supported"
    Write-Host "Supported file format : .json"
    Exit

}

if ($Mode -eq "AddUsers"){

    $Password = Read-Host "Insert default password" -AsSecureString
    Write-Host "Creating users ..."

    foreach($Object in $Objects.Units){

        try{
            $null = New-ADUser -Name $Object.Name -AccountPassword $Password -Enabled $true -Surname $Object.Surname -GivenName $Object.GivenName -EmailAddress $Object.EmailAddress -SamAccountName $Object.SamAccountName -DisplayName $Object.DisplayName -Country $Object.Country -City $Object.City -PassThru -ChangePasswordAtLogon $true
        } catch {}
    }

} elseif ($Mode -eq "AddGroups"){

    Write-Host "Creating groups ..."

    foreach($Object in $Objects.Units){

        try{
            $null = New-ADGroup -Name $Object.Name -GroupScope $Object.Scope
        } catch {}
    }

} elseif ($Mode -eq "DelUsers"){

    Write-Host "Deleting users ..."

    foreach($Object in $Objects.Units){

        try{
            $null = Remove-ADUser -Identity $Object.SamAccountName -Confirm:$false
        } catch {}
    } 

} elseif ($Mode -eq "DelGroups"){

    Write-Host "Deleting groups ..."

    foreach($Object in $Objects.Units){
    
        try{
            $null = Remove-ADGroup -Identity $Object.Name -Confirm:$false
        } catch {}
    }

} else {

    Write-Host "Invalid mode parameter"
    Write-Host "Available modes : AddObjects, AddGroups, DelObjects, DelGroups"
    Exit

}
