
param($InputFile)
$machines = Get-content $InputFile

foreach ($machine in $machines){
 if (Test-Connection -ComputerName $machine -Count 1 -ErrorAction SilentlyContinue){
   Write-Host "$machine,up" -ForegroundColor Green
 }
 else{
   Write-Host "$machine,down" -ForegroundColor Red
     } 
 }