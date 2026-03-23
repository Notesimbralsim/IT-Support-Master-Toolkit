# 🛠️ IT Support Master Toolkit

An all-in-one, portable batch/PowerShell script designed to automate common IT Helpdesk tasks, troubleshoot Windows issues, and perform system maintenance with a single click.

## 🌟 Features

This toolkit includes 6 essential functions for IT Support:

1. **📦 Install Basic Applications:** Automates the installation of standard corporate software (Chrome, 7-Zip, VLC, Notepad++, Zoom, Firefox) using `winget` with smart detection (skips if already installed).
2. **🖨️ Fix Printer & Share Drive:** Stops the Print Spooler, clears stuck print queues, and restarts related file-sharing services (LanmanServer/Workstation).
3. **💻 Get PC Information:** Quickly fetches critical system data including PC Name, Username, IPv4 Address, OS Version, and Drive C: free space for remote support.
4. **🧹 Deep PC Cleaner:** Clears the Recycle Bin, User/Windows Temp folders, and resets the Windows Update cache (SoftwareDistribution) to resolve update errors.
5. **🩺 PC Health Diagnostic:** Analyzes system health by checking uptime, CPU/RAM usage, physical disk health, and internet connectivity. Highlights critical issues in red.
6. **🌐 Network Fixer:** Flushes DNS cache, releases/renews IP address, and resets the Winsock catalog to resolve common connectivity issues.

## 🚀 How to Use

No installation required. This is a "Polyglot" script combining Batch and PowerShell.

1. Download the `IT-Toolkit-All-In-One.cmd` file.
2. Double-click the file to run it.
3. Accept the UAC (Administrator privileges) prompt. The script automatically requests admin rights.
4. Type the number corresponding to the tool you want to use and press `Enter`.

## 🛠️ Tech Stack
* **Language:** PowerShell, Windows Batch Script
* **Package Manager:** Windows Package Manager (Winget)
* **Design:** Polyglot Script (Batch wrapper executing PowerShell)

## 👤 Author
Developed by **Natdanai patike**
