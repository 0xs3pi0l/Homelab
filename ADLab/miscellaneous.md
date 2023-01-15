## Get all local user accounts
    
`Get-LocalUser`

## Get all local groups
    
`Get-LocalGroup`

## Get all members from a specific group

`Get-LocalGroupMember`

## To create a new local user

`$Password = Read-Host -AsSecureString`
`New-LocalUser -Name Optimus -Description “Second Admin Account” -Password $Password`

## Change local user account pwd

`Get-LocalUser -Name user1 | Set-LocalUser -Password $Password`

## Add local user account to group

`Add-LocalGroupMember -Group "Administrators" -Member user1`

## Remove local user account to group

`Remove-LocalGroupMember -Group "Administrators" -Member user1`

## Set execution policy

`Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force`

