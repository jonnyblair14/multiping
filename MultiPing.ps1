param(
  [string]$InputFile,
  [string]$OutputFile
)

#Create a working array to store results
$results = @()

# Read the list of machines from the input .csv file
$machines = Import-Csv $InputFile

foreach ($machine in $machines) {
  $ip = $machine.ipAddress
  $status = if (Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue) {
    "up"
  } else {
    "down"
  }
  
  # Create custom object for each machine and add it to the results array
  $resultObject = [PSCustomObject]@{
    HOSTNAME = $machine.hostname
    IP = $ip
    MAC = $machine.macAddress
    DESCRIPTION = $machine.description
    STATUS = $status
  }
  $results += $resultObject

  # Display result in the terminal
  Write-Host "$($machine.hostname), $ip, $($machine.macAddress), $status" -ForegroundColor $(if ($status -eq 'up') {'Green'} else {'Red'})
}

# Export Results to .csv with headers
$results | Export-Csv -Path $OutputFile -NoTypeInformation -Force

# Display results in terminal
$results