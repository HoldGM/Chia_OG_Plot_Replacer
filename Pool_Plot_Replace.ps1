
$config = Get-Content -Raw -Path .\config.json | ConvertFrom-Json

# Initial checks for valid json config
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

$gFlag = ""

if($config.madmax_G_flag){
    $gFlag = "-G"
}
# Check if path to new pool plot location exists, not create directory for plots
if(!(Test-Path $config.pool_plot_location)){
    New-Item -ItemType Directory -Force -Path $config.pool_plot_location
}

#List of old plots to be replaced
$oldPlotList = Get-ChildItem -Path "$($config.old_plot_location)*.plot" | Sort CreationTime

# Start replacement of old plots
$i = 1
$initCount = ($oldPlotList | Measure-Object).Count
Write-Host "Init Count: $($initCount)"
foreach ($file in $oldPlotList){
    Write-Host "$($i) of $($initCount) - Removing Plot - $($file)"
    Remove-Item $file
    $t1 = $config.temp1
    $t2 = $config.temp2
    if($config.madmax_G_flag){
        if($i % 2 -eq 0){
            $t1 = $config.temp2
            $t2 = $config.temp1
        }
    }
    Start-Process -NoNewWindow -Wait -FilePath $($config.madmax_exec) -ArgumentList "-n 1 -r $($config.threads) -u $($config.bucket_count) -t $($t1) -2 $($t2) -d $($config.pool_plot_location) $($gFlag) -f $($config.farmer_key) -c $($config.contract_NFT)"
    $i = $i + 1
}