<# :
@echo off
title IT Support Master Toolkit
color 0B

:: ตรวจสอบและขอสิทธิ์ Admin อัตโนมัติ
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator Privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: สั่งให้ PowerShell อ่านโค้ดด้านล่าง
powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((Get-Content '%~f0' -Raw))"
exit /b
#>

# ========================================================================================
# POWERSHELL SCRIPT STARTS HERE
# Author: Natdanai patike
# ========================================================================================

# ฟังก์ชันที่ 1: Install Apps
function Install-Apps {
    Write-Host "`n=== Starting Auto Installation ===" -ForegroundColor Cyan
    $applications = @("Google.Chrome", "7zip.7zip", "VideoLAN.VLC", "Notepad++.Notepad++", "Zoom.Zoom", "Mozilla.Firefox")
    foreach ($app in $applications) {
        Write-Host "-> Checking: $app" -ForegroundColor Yellow
        winget list --id $app --exact --accept-source-agreements > $null 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "   [Skipped] Already installed." -ForegroundColor DarkGray
        } else {
            winget install --id $app --exact --silent --accept-package-agreements --accept-source-agreements
            Write-Host "   [Success] Installed $app" -ForegroundColor Green
        }
    }
    Read-Host "`nPress Enter to return to menu..."
}

# ฟังก์ชันที่ 2: Fix Printer
function Fix-Printer {
    Write-Host "`n=== Fix Printer & Share Drive ===" -ForegroundColor Cyan
    $servicesToRestart = @("Spooler", "LanmanServer", "LanmanWorkstation")
    foreach ($service in $servicesToRestart) {
        try {
            if ($service -eq "Spooler") {
                Stop-Service -Name $service -Force -ErrorAction Stop
                $printQueuePath = "$env:windir\System32\spool\PRINTERS\*.*"
                Remove-Item -Path $printQueuePath -Force -Recurse -ErrorAction SilentlyContinue
                Start-Service -Name $service -ErrorAction Stop
                Write-Host "   [Success] Spooler restarted & Queue Cleared." -ForegroundColor Green
            } else {
                Restart-Service -Name $service -Force -ErrorAction Stop
                Write-Host "   [Success] '$service' has been restarted." -ForegroundColor Green
            }
        } catch {
            Write-Host "   [Error] Failed to process '$service'." -ForegroundColor Red
        }
    }
    Read-Host "`nPress Enter to return to menu..."
}

# ฟังก์ชันที่ 3: Get PC Info
function Get-PCInfo {
    Write-Host "`n=== PC Information Grabber ===" -ForegroundColor Cyan
    $pcName = $env:COMPUTERNAME
    $currentUser = $env:USERNAME
    $os = (Get-CimInstance Win32_OperatingSystem).Caption
    $ipAddress = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notmatch "Loopback" } | Select-Object -First 1).IPAddress
    $driveC = Get-Volume -DriveLetter C
    $freeSpace = [math]::Round(($driveC.SizeRemaining / 1GB), 2)
    $totalSpace = [math]::Round(($driveC.Size / 1GB), 2)
    
    Write-Host "----------------------------------------" -ForegroundColor White
    Write-Host " PC Name    : $pcName" -ForegroundColor Green
    Write-Host " Username   : $currentUser" -ForegroundColor Green
    Write-Host " IP Address : $ipAddress" -ForegroundColor Yellow
    Write-Host " OS Version : $os" -ForegroundColor White
    Write-Host " Drive C:   : $freeSpace GB Free (out of $totalSpace GB)" -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor White
    Read-Host "`nPress Enter to return to menu..."
}

# ฟังก์ชันที่ 4: Deep Clean
function Deep-Clean {
    Write-Host "`n=== Deep PC Cleaner ===" -ForegroundColor Cyan
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue 2>$null
    Write-Host "   [Success] Recycle Bin cleared." -ForegroundColor Green
    
    $userTemp = "$env:TEMP\*"
    Remove-Item -Path $userTemp -Recurse -Force -ErrorAction SilentlyContinue 2>$null
    Write-Host "   [Success] Temp files cleaned." -ForegroundColor Green
    
    try {
        Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue 2>$null
        $wuCache = "$env:windir\SoftwareDistribution\Download\*"
        Remove-Item -Path $wuCache -Recurse -Force -ErrorAction SilentlyContinue 2>$null
        Start-Service -Name wuauserv -ErrorAction SilentlyContinue 2>$null
        Write-Host "   [Success] Windows Update cache cleared." -ForegroundColor Green
    } catch {}
    Read-Host "`nPress Enter to return to menu..."
}

# ฟังก์ชันที่ 5: PC Health Check
function Health-Check {
    Write-Host "`n=== PC Health Diagnostic ===" -ForegroundColor Cyan
    
    # Uptime
    $os = Get-CimInstance Win32_OperatingSystem
    $uptime = (Get-Date) - $os.LastBootUpTime
    if ($uptime.Days -gt 7) {
        Write-Host "[!] Uptime: $($uptime.Days) days (Warning: Needs Restart)" -ForegroundColor Red
    } else {
        Write-Host "[*] Uptime: $($uptime.Days) days" -ForegroundColor Green
    }
    
    # CPU
    $cpu = Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    if ($cpu -gt 85) { Write-Host "[!] CPU: $cpu % (High Load)" -ForegroundColor Red }
    else { Write-Host "[*] CPU: $cpu % (Normal)" -ForegroundColor Green }
    
    # RAM
    $totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    $freeRam = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $ramPercent = [math]::Round((($totalRam - $freeRam) / $totalRam) * 100, 2)
    if ($ramPercent -gt 90) { Write-Host "[!] RAM: $ramPercent % ($freeRam GB Free) (Low Memory)" -ForegroundColor Red }
    else { Write-Host "[*] RAM: $ramPercent % ($freeRam GB Free) (Normal)" -ForegroundColor Green }
    
    # Disk Health
    try {
        $disks = Get-PhysicalDisk
        foreach ($disk in $disks) {
            if ($disk.HealthStatus -eq "Healthy") { Write-Host "[*] Disk $($disk.DeviceId): $($disk.HealthStatus)" -ForegroundColor Green }
            else { Write-Host "[!] Disk $($disk.DeviceId): $($disk.HealthStatus)" -ForegroundColor Red }
        }
    } catch { Write-Host "[-] Could not retrieve disk health." -ForegroundColor DarkGray }
    
    # Network
    $ping = Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet
    if ($ping) { Write-Host "[*] Internet: Connected" -ForegroundColor Green }
    else { Write-Host "[!] Internet: Disconnected" -ForegroundColor Red }
    
    Read-Host "`nPress Enter to return to menu..."
}

# ฟังก์ชันที่ 6: Network Fixer
function Reset-Network {
    Write-Host "`n=== Network Reset & DNS Flush ===" -ForegroundColor Cyan
    Write-Host "-> Flushing DNS Cache..." -ForegroundColor Yellow
    ipconfig /flushdns | Out-Null
    
    Write-Host "-> Releasing and Renewing IP Address (This may take a moment)..." -ForegroundColor Yellow
    ipconfig /release | Out-Null
    ipconfig /renew | Out-Null
    
    Write-Host "-> Resetting Winsock Catalog..." -ForegroundColor Yellow
    netsh winsock reset | Out-Null
    
    Write-Host "   [Success] Network settings have been reset!" -ForegroundColor Green
    Write-Host "   [*] Note: A PC restart might be required for changes to take full effect." -ForegroundColor DarkGray
    Read-Host "`nPress Enter to return to menu..."
}

# ========================================================================================
# MAIN MENU LOOP
# ========================================================================================
while ($true) {
    Clear-Host
    Write-Host "=====================================================" -ForegroundColor Cyan
    Write-Host "              IT SUPPORT MASTER TOOLKIT              " -ForegroundColor White
    Write-Host "                 By: Natdanai patike                 " -ForegroundColor DarkGray
    Write-Host "=====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    [1] Install Basic Applications"
    Write-Host "    [2] Fix Printer & Share Drive"
    Write-Host "    [3] Get PC Information (IP, Disk)"
    Write-Host "    [4] Deep PC Cleaner"
    Write-Host "    [5] PC Health Diagnostic"
    Write-Host "    [6] Network Fixer (Reset IP/DNS)"
    Write-Host "    [7] Exit"
    Write-Host ""
    Write-Host "=====================================================" -ForegroundColor Cyan

    $choice = Read-Host "Please select an option (1-7)"

    switch ($choice) {
        "1" { Install-Apps }
        "2" { Fix-Printer }
        "3" { Get-PCInfo }
        "4" { Deep-Clean }
        "5" { Health-Check }
        "6" { Reset-Network }
        "7" { exit }
        default {
            Write-Host "`nInvalid choice! Press Enter to try again..." -ForegroundColor Red
            Read-Host
        }
    }
}