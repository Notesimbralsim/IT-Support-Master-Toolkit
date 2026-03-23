# 🛠️ IT Support & Security Master Toolkit

*[Scroll down for English version 🇬🇧](#english-version)*

สคริปต์ All-in-one แบบพกพาที่ผสมผสานระหว่าง Batch และ PowerShell ออกแบบมาเพื่อช่วยลดขั้นตอนการทำงาน (Automate) ของ IT Helpdesk ทั้งในด้านการแก้ไขปัญหาคอมพิวเตอร์เบื้องต้น, การจัดการทรัพย์สินไอที (Asset Management) และการยกระดับความปลอดภัยของระบบ (Security Hardening) จบได้ในสคริปต์เดียว

## 🌟 ฟีเจอร์หลัก (Features)

ชุดเครื่องมือนี้ประกอบด้วยฟังก์ชันที่ครอบคลุมงาน IT Support และ System Admin:

1. **📦 ติดตั้งโปรแกรมพื้นฐานอัตโนมัติ (Install Basic Applications):** ติดตั้งซอฟต์แวร์มาตรฐานสำหรับองค์กร (Chrome, 7-Zip, VLC, Notepad++, Zoom, Firefox) ผ่านคำสั่ง `winget` พร้อมระบบตรวจสอบอัจฉริยะ (ข้ามการติดตั้งหากมีโปรแกรมอยู่แล้ว)
2. **🖨️ ซ่อมแซมระบบปริ้นเตอร์และแชร์ไดร์ฟ (Fix Printer & Share Drive):** สั่งหยุดการทำงานของ Print Spooler, ล้างไฟล์คิวปริ้นเตอร์ที่ค้าง และรีสตาร์ท Service ที่เกี่ยวข้องกับการแชร์ไฟล์ (LanmanServer/Workstation)
3. **💻 ตรวจสอบข้อมูลสเปคเครื่อง (Get PC Information):** ดึงข้อมูลสำคัญของระบบอย่างรวดเร็ว เช่น ชื่อเครื่อง, ชื่อผู้ใช้, IP Address, รุ่นของ Windows และพื้นที่ว่างของไดร์ฟ C:
4. **🧹 ทำความสะอาดไฟล์ขยะขั้นลึก (Deep PC Cleaner):** สั่งเทถังขยะ (Recycle Bin), ล้างไฟล์ Temp และรีเซ็ตแคชของ Windows Update (SoftwareDistribution) เพื่อแก้ปัญหาอัปเดตติดขัด
5. **🩺 ตรวจสอบสุขภาพระบบ (PC Health Diagnostic):** วิเคราะห์ความสมบูรณ์ของคอมพิวเตอร์โดยเช็คระยะเวลาการเปิดเครื่องค้างไว้ (Uptime), การทำงานของ CPU/RAM และการเชื่อมต่ออินเทอร์เน็ต
6. **🌐 ซ่อมแซมและรีเซ็ตเครือข่าย (Network Fixer):** ล้างแคช DNS, คืนค่าและขอรับ IP Address ใหม่ รวมถึงรีเซ็ต Winsock catalog เพื่อแก้ปัญหาเข้าเน็ตไม่ได้
7. **📊 ออกรายงานทรัพย์สินไอที (IT Asset Inventory Reporter):** [NEW] สแกนข้อมูลฮาร์ดแวร์เชิงลึก (Serial Number, รุ่น CPU, ขนาด RAM, Storage) และบันทึกส่งออกเป็นไฟล์ `IT_Inventory_Report.csv` ให้โดยอัตโนมัติ
8. **🛡️ เมนูจัดการความปลอดภัย (Security Hardening Menu):** [NEW] เมนูย่อยสำหรับปิดช่องโหว่และยกระดับความปลอดภัยให้ Windows ประกอบด้วย:
   - บังคับเปิด Windows Defender (Real-time Protection)
   - ปิดโปรโตคอล SMBv1 เพื่อป้องกัน Ransomware (เช่น WannaCry)
   - ปิดระบบ AutoRun จาก USB เพื่อป้องกันไวรัส
   - บังคับเปิดใช้งาน Windows Firewall ทุกโปรไฟล์
   - ตั้งค่า UAC (User Account Control) ให้แจ้งเตือนในระดับสูงสุด

## 🚀 วิธีการใช้งาน

สคริปต์นี้เป็นแบบ "Polyglot" (รวม Batch และ PowerShell ไว้ด้วยกันในไฟล์เดียว) ไม่ต้องติดตั้งโปรแกรมหรือโมดูลใดๆ เพิ่มเติม

1. ดาวน์โหลดไฟล์ `IT-Toolkit-Final.cmd`
2. ดับเบิ้ลคลิกเพื่อรันไฟล์
3. กด `Yes` เมื่อระบบถามหาหน้าต่าง UAC (สคริปต์จะขอสิทธิ์ Administrator โดยอัตโนมัติ)
4. พิมพ์ตัวเลขเมนูที่ต้องการใช้งาน แล้วกด `Enter`

## 🛠️ เทคโนโลยีที่ใช้ (Tech Stack)
* **Language:** PowerShell, Windows Batch Script
* **Package Manager:** Windows Package Manager (Winget)
* **Design:** Polyglot Script (ใช้ Batch ย้าย Working Directory และเรียกใช้งาน PowerShell เบื้องหลัง)

---

<a id="english-version"></a>
# 🇬🇧 English Version

An all-in-one, portable batch/PowerShell script designed to automate common IT Helpdesk troubleshooting, simplify IT Asset Management, and perform System Security Hardening with a single click.

## 🌟 Features

This toolkit includes powerful functions for IT Support and System Administration:

1. **📦 Install Basic Applications:** Automates the installation of standard corporate software (Chrome, 7-Zip, VLC, Notepad++, Zoom, Firefox) using `winget` with smart detection (skips if already installed).
2. **🖨️ Fix Printer & Share Drive:** Stops the Print Spooler, clears stuck print queues, and restarts related file-sharing services (LanmanServer/Workstation).
3. **💻 Get PC Information:** Quickly fetches critical system data including PC Name, Username, IPv4 Address, OS Version, and Drive C: free space for remote support.
4. **🧹 Deep PC Cleaner:** Clears the Recycle Bin, User/Windows Temp folders, and resets the Windows Update cache (SoftwareDistribution) to resolve update errors.
5. **🩺 PC Health Diagnostic:** Analyzes system health by checking uptime, CPU usage, and internet connectivity.
6. **🌐 Network Fixer:** Flushes DNS cache, releases/renews IP address, and resets the Winsock catalog to resolve common connectivity issues.
7. **📊 IT Asset Inventory Reporter:** [NEW] Scans deep hardware details (Serial Number, CPU Model, RAM, Storage types) and automatically exports the data to a `IT_Inventory_Report.csv` file.
8. **🛡️ Security Hardening Menu:** [NEW] A dedicated sub-menu to secure the OS against common threats. Features include:
   - Enabling Windows Defender Real-time Protection
   - Disabling SMBv1 protocol (Ransomware protection)
   - Disabling USB AutoRun/AutoPlay (Malware prevention)
   - Enforcing Windows Firewall across all profiles
   - Hardening UAC (User Account Control) prompt behavior

## 🚀 How to Use

No installation or external modules required. This is a "Polyglot" script combining Batch and PowerShell.

1. Download the `IT-Toolkit-Final.cmd` file.
2. Double-click the file to run it.
3. Accept the UAC (Administrator privileges) prompt. The script automatically requests admin rights.
4. Type the number corresponding to the tool you want to use and press `Enter`.

## 🛠️ Tech Stack
* **Language:** PowerShell, Windows Batch Script
* **Package Manager:** Windows Package Manager (Winget)
* **Design:** Polyglot Script (Batch wrapper executing PowerShell seamlessly)

---

## 👤 Author / ผู้พัฒนา
Developed by **Natdanai patike**
