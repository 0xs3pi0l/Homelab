## To create a new ADUser 

`New-ADUser -Name Johnw -Surname "Williams" -GivenName "John" -EmailAddress "john.williams@techibee.ad" -SamAccountName "johnw" -AccountPassword $password -DisplayName "John Williams" -Department "Sales" -Country "US" -City "New York" -Path "OU=LAB,DC=Techibee,DC=AD" -Enabled $true -PassThru`

 ## Retrieve user object based on property

 `Get-ADUser -Filter {Name -eq "name"}`

 ## Retrieve all user objects in a specific OU

 `Get-ADUser -Filter * -SearchBase "OU=Domain Controllers,DC=allsafe,DC=com"`

 ## Change user object property

 `Set-ADUser -Identity $user -Description "description"`

 - Note that when we do an assignment to a variable and we change a property from the original object, then we need to repeat the assignment to be able to see the new value of the property

 ## Enable or disable user account

 `Enable-ADAccount -Identity $user`

 `Disable-ADAccount -Identity $user`

 - To enable (or disable) all users listed in a file

 `Get-Content .\file_path | % {Enable-ADAccount -Identity $_}`

 ## Create an OU

 `New-ADOrganizationalUnit -Name "Test" -Path "DC=allsafe,DC=com"`

 ## Retrieve all OUs

 `Get-ADOrganizationalUnit -Filter *`

 ## Move an AD object from one OU to another 

 `Move-ADObject -Identity GUID_OR_DN -TargetPath "DN"`

 ## To delete 

`Remove-ADObject -Identity GUID_OR_DN `

- Note that by default every AD object has the *ProtectedFromAccidentalDeletion* property set to true. This means that, in order to move objects in a specific OU or to delete it, we first need to disable the protection

`Set-ADObject -Identity $OU -ProtectedFromAccidentalDeletion $false`

## Remove a user account

`Remove-ADUser -Identity $user`

## Remove all users listed into a file

`Get-Content C:\temp\users.txt | % { Remove-ADUser -Identity $_ -Confirm:$false}`

## Create a computer account object

`New-ADComputer -Name PC1`

## Modify computer account object properties

`Set-ADComputer -identity $PC_OR_DN -description "New description`

- "description" can be swapped with wathever property we want to change

## To get all computer objects

`Get-ADComputer -Filter *`

## To create a computer account object

`New-ADComputer -Name NAME -Path PATH`

- Path can be omitted

## To retrieve a computer account object by the description field

`Get-ADComputer -Filter "description -like 'server*'" | Move-ADObject -TargetPath "DN" -PassThru`

## To enable (or disable) a computer account 

`Enable-ADAccount`

`Disable-ADAccount`

## To remove an AD computer account 

`Remove-ADComputer -Identity COMP1`

## To search computers older then x days and delete them 

`$Computers = Get-ADComputer -Filter * -Properties LastLogonDate | ? {$_.LastLogonDate -lt (get-date).Adddays(-10) }``$Computers | Remove-ADComputer`

 # Miscellaneous

 - Create new file

 `New-Item .\file_path`

 - Append content to the file 

 `Add-Content .\file_path "text"`

