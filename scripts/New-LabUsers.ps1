# New-LabUsers.ps1
# Bulk-creates AD users from a CSV and places each one in its department OU.
# CSV columns: FirstName, LastName, Username, Department
param(
    [string]$CsvPath = "C:\LabScripts\users.csv"
)

$Domain   = "lab.local"
$UsersOU  = "OU=Users,OU=_LAB,DC=lab,DC=local"
$Password = Read-Host "Temporary password for new users" -AsSecureString

Import-Csv $CsvPath | ForEach-Object {
    $ou = "OU=$($_.Department),$UsersOU"

    # Skip anyone who already exists so the script is safe to re-run
    if (Get-ADUser -Filter "SamAccountName -eq '$($_.Username)'") {
        Write-Warning "$($_.Username) already exists - skipped"
        return
    }

    New-ADUser -Name "$($_.FirstName) $($_.LastName)" `
        -GivenName $_.FirstName `
        -Surname $_.LastName `
        -DisplayName "$($_.FirstName) $($_.LastName)" `
        -SamAccountName $_.Username `
        -UserPrincipalName "$($_.Username)@$Domain" `
        -Department $_.Department `
        -Path $ou `
        -AccountPassword $Password `
        -ChangePasswordAtLogon $true `
        -Enabled $true

    Write-Host "Created $($_.Username) in $($_.Department)" -ForegroundColor Green
}
