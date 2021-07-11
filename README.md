# Chia_OG_Plot_Replacer
Powershell automation tool for replacing Solor Chia Plots with Portable Chia Plots using Madmax Chia Plotter for Windows

## Description

In combination with madMAx43v3r Chia Plotter, this Windows Powershell Script will automatically remove exisitng Chia Plots and execute a the madMAx43v3r Chiaa Plotter to generate a replacement portable pool plot. 

## Getting Started

### Dependencies

* Download Stotik's madMAx43v3r Chia Plotter build for windows
*   https://github.com/stotiks/chia-plotter/releases

### Installing

* Clone repo to your local machine
```
git clone https://github.com/HoldGM/Chia_OG_Plot_Replacer.git
```

### Executing program

* Update config.json with paramters
```
    --old_plot_location:
              File path to location of old plots to be replace 
    --pool_plot_location:
              File path to location of new portable plot. It is recommended to create a new directory for new portable plots to be stored to avoid mixing with old plots
    --madmax_exec:
              File path to Madmax chia plotter executable
    --threads:
              Number of threads to use running plotter
    --bucket_count:
              Number of buckets
    --temp1:
              Temp 1 file path
    --temp2:
              Temp 2 file path - Optional - Can be left empty when using only Temp 1 location
    --contract_NFT:
              NFT Contract address generated from Chia CLI or GUI
    --farmer_key:
              Farmer public key
    --madmax_G_flag:
              Set to True/False to enable/disable use of plotter -G flag to rotate temp 1 & temp 2 drives. Set to false when not using a Temp 2 location or using RamDisk as Temp 2 location for plotting
```
* Start Windows Powershel & navigate to location where Chia_OG_Plot_Replacer was cloned
```
> .\Pool_Plot_Replace.ps1
```

## Help

If script fails to execute with:
```
\Pool_Plot_Replace.ps1 cannot be loaded because running scripts is disabled on this system.
```
Close Powershell and reopen as Administrator and run: 
```
> set-executionpolicy remotesigned
```
Close Administrator console, open new Powershell console and attempt to run script again

## Authors

Contributors names and contact info:
    Otis Brower 
    
## Acknowledgments

* [madMAx43v3r](https://github.com/madMAx43v3r/chia-plotter)
* [stotiks](https://github.com/stotiks/chia-plotter/releases)
