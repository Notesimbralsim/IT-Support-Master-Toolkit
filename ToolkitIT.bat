<# :
@echo off
title IT Support ^& Security Master Toolkit v2.0 - By Natdanai patike
color 0B

:: 1. ตรวจสอบและขอสิทธิ์ Admin อัตโนมัติ
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator Privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: 2. ย้ายตำแหน่ง Working Directory มาที่โฟลเดอร์ของไฟล์นี้
cd /d "%~dp0"

:: 3. สั่งให้ PowerShell อ่านโค้ดด้านล่าง
powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((Get-Content '%~f0' -Raw))"
exit /b
#>

# ========================================================================================
# POWERSHELL SCRIPT STARTS HERE
# Author: Natdanai patike
# ========================================================================================

# --- ฟังก์ชันช่วยเหลือ (Utility) ---
function Pause-Menu {
    Read-Host "`nPress Enter to return to menu..."
}

# --- [1] Install Apps ---
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
    Pause-Menu
}

# --- [2] Fix Printer ---
function Fix-Printer {
    Write-Host "`n=== Fix Printer & Share Drive ===" -ForegroundColor Cyan
    $servicesToRestart = @("Spooler", "LanmanServer", "LanmanWorkstation")
    foreach ($service in $servicesToRestart) {
        try {
            if ($service -eq "Spooler") {
                Stop-Service -Name $service -Force -ErrorAction Stop
                $printQueuePath = "$env:windir\System32\spool\PRINTERS\*.*"
                Remove-Item -Path $printQueuePath -Force -Recurse -ErrorAction SilentlyContinue 2>$null
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
    Pause-Menu
}

# --- [3] Get PC Info ---
function Get-PCInfo {
    Write-Host "`n=== PC Information Grabber ===" -ForegroundColor Cyan
    $pcName = $env:COMPUTERNAME
    $currentUser = $env:USERNAME
    $os = (Get-CimInstance Win32_OperatingSystem).Caption
    $ipAddress = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notmatch "Loopback" } | Select-Object -First 1).IPAddress
    $driveC = Get-Volume -DriveLetter C
    $freeSpace = [math]::Round(($driveC.SizeRemaining / 1GB), 2)
    
    Write-Host "----------------------------------------" -ForegroundColor White
    Write-Host " PC Name    : $pcName" -ForegroundColor Green
    Write-Host " Username   : $currentUser" -ForegroundColor Green
    Write-Host " IP Address : $ipAddress" -ForegroundColor Yellow
    Write-Host " OS Version : $os" -ForegroundColor White
    Write-Host " Drive C:   : $freeSpace GB Free" -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor White
    Pause-Menu
}

# --- [4] Deep Clean ---
function Deep-Clean {
    Write-Host "`n=== Deep PC Cleaner ===" -ForegroundColor Cyan
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue 2>$null
    $userTemp = "$env:TEMP\*"
    Remove-Item -Path $userTemp -Recurse -Force -ErrorAction SilentlyContinue 2>$null
    try {
        Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue 2>$null
        $wuCache = "$env:windir\SoftwareDistribution\Download\*"
        Remove-Item -Path $wuCache -Recurse -Force -ErrorAction SilentlyContinue 2>$null
        Start-Service -Name wuauserv -ErrorAction SilentlyContinue 2>$null
        Write-Host "   [Success] System cleaned and Update cache cleared." -ForegroundColor Green
    } catch {}
    Pause-Menu
}

# --- [5] Health Check ---
function Health-Check {
    Write-Host "`n=== PC Health Diagnostic ===" -ForegroundColor Cyan
    $os = Get-CimInstance Win32_OperatingSystem
    $uptime = (Get-Date) - $os.LastBootUpTime
    Write-Host "[*] Uptime: $($uptime.Days) days, $($uptime.Hours) hours" -ForegroundColor Green
    $cpu = Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    Write-Host "[*] CPU Usage: $cpu %" -ForegroundColor Green
    $ping = Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet
    Write-Host "[*] Internet: $(if($ping){'Connected'}else{'Disconnected'})" -ForegroundColor Green
    Pause-Menu
}

# --- [6] Network Fixer ---
function Reset-Network {
    Write-Host "`n=== Network Reset & DNS Flush ===" -ForegroundColor Cyan
    ipconfig /flushdns | Out-Null
    ipconfig /release | Out-Null
    ipconfig /renew | Out-Null
    netsh winsock reset | Out-Null
    Write-Host "   [Success] Network settings reset successfully." -ForegroundColor Green
    Pause-Menu
}

# --- [7] Asset Inventory ---
function Generate-Inventory {
    Write-Host "`n=== IT Asset Inventory Reporter ===" -ForegroundColor Cyan
    $FilePath = "$PSScriptRoot\IT_Inventory_Report.csv"
    if ($PSScriptRoot -eq $null) { $FilePath = ".\IT_Inventory_Report.csv" }
    $osInfo = Get-CimInstance Win32_OperatingSystem
    $bios   = Get-CimInstance Win32_Bios
    $cs     = Get-CimInstance Win32_ComputerSystem
    $ReportData = [PSCustomObject]@{
        Date         = (Get-Date -Format "yyyy-MM-dd HH:mm")
        ComputerName = $env:COMPUTERNAME
        User         = $env:USERNAME
        Model        = $cs.Model
        SerialNumber = $bios.SerialNumber
        CPU          = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
        RAM_GB       = [math]::Round($osInfo.TotalVisibleMemorySize / 1MB, 0)
        Storage      = (Get-PhysicalDisk | ForEach-Object { "$($_.MediaType) $([math]::Round($_.Size/1GB,0))GB" }) -join " | "
        Windows      = $osInfo.Caption
    }
    try {
        $ReportData | Export-Csv -Path $FilePath -Append -NoTypeInformation -Encoding UTF8
        Write-Host "----------------------------------------" -ForegroundColor White
        Write-Host " [Success] Data saved to: " -NoNewline; Write-Host "$FilePath" -ForegroundColor Yellow
        Write-Host "----------------------------------------" -ForegroundColor White
    } catch { Write-Host " [Error] Could not save CSV file!" -ForegroundColor Red }
    Pause-Menu
}

# --- [8] SECURITY HARDENING MENU (NEW!) ---
function Security-Menu {
    while ($true) {
        Clear-Host
        Write-Host "=====================================================" -ForegroundColor Red
        Write-Host "             IT SECURITY HARDENING MENU              " -ForegroundColor White
        Write-Host "=====================================================" -ForegroundColor Red
        Write-Host " [1] Enable Windows Defender (Real-time Protection)"
        Write-Host " [2] Disable SMBv1 (Protect against Ransomware)"
        Write-Host " [3] Disable USB AutoRun (Prevent Virus spread)"
        Write-Host " [4] Enforce Firewall (All Profiles)"
        Write-Host " [5] Harden UAC (Always Notify)"
        Write-Host " [6] RUN ALL SECURITY FIXES"
        Write-Host " [7] Back to Main Menu"
        Write-Host "=====================================================" -ForegroundColor Red
        
        $secChoice = Read-Host "Select security option (1-7)"
        
        switch ($secChoice) {
            "1" { 
                Set-MpPreference -DisableRealtimeMonitoring $false
                Write-Host "   [Success] Windows Defender Enabled." -ForegroundColor Green; Start-Sleep 1 
            }
            "2" { 
                Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
                Write-Host "   [Success] SMBv1 Disabled." -ForegroundColor Green; Start-Sleep 1 
            }
            "3" { 
                $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
                if (!(Test-Path $regPath)) { New-Item $regPath -Force }
                Set-ItemProperty $regPath -Name "NoDriveTypeAutoRun" -Value 255
                Write-Host "   [Success] AutoRun Disabled." -ForegroundColor Green; Start-Sleep 1 
            }
            "4" { 
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
                Write-Host "   [Success] Firewall Enforced." -ForegroundColor Green; Start-Sleep 1 
            }
            "5" { 
                Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 2
                Write-Host "   [Success] UAC Hardened." -ForegroundColor Green; Start-Sleep 1 
            }
            "6" { 
                Write-Host "`nRunning all security fixes..." -ForegroundColor Yellow
                Set-MpPreference -DisableRealtimeMonitoring $false
                Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
                Write-Host "   [Done] System is now more secure!" -ForegroundColor Green; Start-Sleep 2
            }
            "7" { return }
        }
    }
}

# ========================================================================================
# MAIN MENU LOOP
# ========================================================================================
while ($true) {
    Clear-Host
    Write-Host "=====================================================" -ForegroundColor Cyan
    Write-Host "           IT SUPPORT MASTER TOOLKIT v2.0            " -ForegroundColor White
    Write-Host "                 By: Natdanai patike                 " -ForegroundColor DarkGray
    Write-Host "=====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    [1] Install Basic Applications"
    Write-Host "    [2] Fix Printer & Share Drive"
    Write-Host "    [3] Get PC Information (Display)"
    Write-Host "    [4] Deep PC Cleaner"
    Write-Host "    [5] PC Health Diagnostic"
    Write-Host "    [6] Network Fixer (Reset IP/DNS)"
    Write-Host "    [7] IT Asset Inventory Reporter (Save CSV)"
    Write-Host "    [8] >> SECURITY HARDENING MENU <<" -ForegroundColor Yellow
    Write-Host "    [9] Exit"
    Write-Host ""
    Write-Host "=====================================================" -ForegroundColor Cyan

    $choice = Read-Host "Please select an option (1-9)"

    switch ($choice) {
        "1" { Install-Apps }
        "2" { Fix-Printer }
        "3" { Get-PCInfo }
        "4" { Deep-Clean }
        "5" { Health-Check }
        "6" { Reset-Network }
        "7" { Generate-Inventory }
        "8" { Security-Menu }
        "9" { exit }
        default {
            Write-Host "`nInvalid choice!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
}