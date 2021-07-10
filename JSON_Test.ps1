$config = Get-Content -Raw -Path .\config.json | ConvertFrom-Json

if(!(Test-Path $config.old_plot_location)){
    Write-Host "Error: Old Plot Location not found"
    exit 1
}

if(!(Test-Path $config.pool_plot_location)){
    Write-Host "Error: Pool Plot Location not found"
    exit 1
}

if(!(Test-Path $config.madmax_exec)){
    Write-Host "Madmax Executable not found"
    exit 1
}

if($null -eq $config.temp1 -or $config.temp1 -eq ""){
    Write-Error "Error: Temp1 is empty"
    exit 1
}elseif (!(Test-Path $config.temp1)) {
    Write-Host "Error: Temp1 location not found"
    exit 1
}

if($null -eq $config.temp2){
    $config | Add-Member -Type NoteProperty -Name 'Temp2' -Value "$($config.temp1)"
    $config | ConvertTo-Json | Set-Content -Path .\config.json
}elseif ($config.temp2 -eq "") {
    $config.temp2 = $config.temp1
}

if($config.temp2.Length -gt 0 -and !(Test-Path $config.temp2)){
    Write-Host "Error: Temp2 location not found"
    exit 1
}

if($null -eq $config.contract_NFT -or $config.contract_NFT.Length -ne 62){
    Write-Host "Error: Pool Contract Key must be 62 Character in Length"
    exit 1
}

if($null -eq $config.farmer_key -or $config.farmer_key.Length -ne 96){
    Write-Host "Error: Farmer Public Key must be 48 Bytes in size"
    exit 1
}

Write-Host "Old Plot Location: $($config.old_plot_location)"
Write-Host "Pool Plot Location: $($config.pool_plot_location)"
Write-Host "Madmax Executable: $($config.madmax_exec)"
Write-Host "Threads: $($config.threads)"
Write-Host "Bucket Count: $($config.bucket_count)"
Write-Host "Temp 1: $($config.temp1)"
Write-Host "Temp 2: $($config.temp2)"
Write-Host "Pool Contract NFT: $($config.contract_NFT)"
Write-Host "Farmer Public Key: $($config.farmer_key)"