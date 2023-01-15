Param(

    [string]$File

)

$JSON = Get-Content -Raw $File | ConvertFrom-Json
New-Item ".\country_codes.txt"

foreach($country in $JSON){

    Add-Content .\country_codes.txt $country.let2

}