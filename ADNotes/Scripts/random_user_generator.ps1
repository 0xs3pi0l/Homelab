Param(

    [Parameter(Mandatory=$true)][int]$UserNum
)

$name 
$surname 
$givenname
$email 
$country
$cities 

$HashTable = @{

    "Units" = @()

}
    
Write-Host "Generating ..."
    
for($i = 1; $i -le $UserNum; $i++){
    
    $name = Get-Content ".\Files\names.txt" | Get-Random
    $surname = Get-Content ".\Files\names.txt" | Get-Random
    $givenname = Get-Content ".\Files\names.txt" | Get-Random
    $email = Get-Content ".\Files\emails.txt" | Get-Random
    $country = Get-Content ".\Files\country_codes.txt" | Get-Random
    $city = Get-Content ".\Files\cities.txt" | Get-Random
    
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

