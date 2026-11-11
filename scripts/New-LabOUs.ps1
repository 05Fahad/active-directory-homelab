# New-LabOUs.ps1
# Creates the lab's OU structure under an existing _LAB OU.
$Base = "OU=_LAB,DC=lab,DC=local"

"Users", "Computers", "Groups", "Disabled Users" | ForEach-Object {
    New-ADOrganizationalUnit -Name $_ -Path $Base
}
"HR", "IT", "Sales" | ForEach-Object {
    New-ADOrganizationalUnit -Name $_ -Path "OU=Users,$Base"
}
New-ADOrganizationalUnit -Name "Workstations" -Path "OU=Computers,$Base"
