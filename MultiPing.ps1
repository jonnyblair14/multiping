
param($InputFile)
$machines = Get-content $InputFile

foreach ($machine in $machines){
 if (Test-Connection -ComputerName $machine -Count 1 -Quiet -ErrorAction SilentlyContinue){
   Write-Host "$machine is online" -ForegroundColor Green
 }
 else{
   Write-Host "$machine is offline" -ForegroundColor Red
     } 
 }

 Pause
