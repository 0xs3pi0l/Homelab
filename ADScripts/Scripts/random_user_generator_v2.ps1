Param(

    [Parameter(Mandatory=$true)][int]$UserNum
)

$name_al = [System.Collections.ArrayList](Get-Content ".\Files\names.txt") 
$email_al = [System.Collections.ArrayList](Get-Content ".\Files\emails.txt" | Get-Random)
$country_al = [System.Collections.ArrayList](Get-Content ".\Files\country_codes.txt" | Get-Random)
$city_al = [System.Collections.ArrayList](Get-Content ".\Files\cities.txt" | Get-Random)

$HashTable = @{

    "Units" = @()

}
    
Write-Host "Generating ..."
    
for($i = 1; $i -le $UserNum; $i++){

    $

    $Entry = @{
    
        "Name" = $name;
        "Surname" = $surname;
        "GivenName" = $givenname;
        "EmailAddress" = $email;
        "SamAccountName" = $name;
        "DisplayName" = $name;
        "Country" = $country;
        "City" = $city;
            
    }
    
    $HashTable.Units += $Entry
    
}
    
$HashTable | ConvertTo-Json -Depth 10 | Out-File ".\users.json"

