## General theory

- Groups in AD are collections of different Active Directory objects such as accounts, computer accounts and groups
- Two type of AD groups
    - Security groups
        - Used to grant permissions to various resources in a network such as shares, NTFS, printers etc ...
    - Distribution Lists/Groups (DL)
        - Email enabled group
        - Info can be shared with a group of people simultaneously using that email
- Both these group are characterized by a scope that identifies the extent to which the group is applied in a domain tree or forest
    - This means that the scope determines if the group can have members from the same domain, different domains or different forests
        - It's the extent to which the group is applied in the domain tree or forest
- In AD there are 3 scope that apply to both this groups
    - Universal
    - Global
    - Domain local
- Using groups to delegate/grant permissions is very scalable

## To create a new AD group (security group)

`New-ADGroup -Name "Group1" -Path "DN" -groupScope domainlocal`

## To get all AD groups 

`Get-ADGroup -Filter *`

- Remember to use the pipe to concatenate multiple commands

`Get-ADGroup -Filter * | select Name`

- We can use the `-LDAPFilter` to get Groups based on the LDAP type of syntax

`Get-ADGroup -LDAPFilter< "(Name=Test Group1)"`

- This filter can also be used with other cmdlets such as `Get-ADUser` or `Get-ADComputer`

## To query for groups that match a particular naming convention

`Get-ADGroup -Filter {Name -like '*test*'}`

## To check if groups from a list are in active directory 

```
$Groups = Get-Content c:\temp\Groups.txt
foreach($Group in $Groups) {
 $GroupObj = Get-ADGroup -Filter {Name -eq $Group}
 if($GroupObj) {
 "{0} : Group Found" -f $Group
 } else {
 "{0} : Group NOT Found" -f $Group
 }
}
```

## To modify the group object information that match a specific name pattern

`Get-ADGroup -Filter {Name -eq "TestGroup"} | Set-ADGroup -Description "This is a test group"`

