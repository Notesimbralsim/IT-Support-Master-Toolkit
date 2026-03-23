# 🛠️ IT Support Master Toolkit

*[Scroll down for English version 🇬🇧](#english-version)*

สคริปต์ All-in-one แบบพกพาที่ผสมผสานระหว่าง Batch และ PowerShell ออกแบบมาเพื่อช่วยลดขั้นตอนการทำงาน (Automate) ของ IT Helpdesk ในการแก้ไขปัญหาคอมพิวเตอร์เบื้องต้นและบำรุงรักษาระบบ จบได้ในคลิกเดียว

## 🌟 ฟีเจอร์หลัก (Features)

ชุดเครื่องมือนี้ประกอบด้วย 6 ฟังก์ชันที่ครอบคลุมงาน IT Support:

1. **📦 ติดตั้งโปรแกรมพื้นฐานอัตโนมัติ (Install Basic Applications):** ติดตั้งซอฟต์แวร์มาตรฐานสำหรับองค์กร (Chrome, 7-Zip, VLC, Notepad++, Zoom, Firefox) ผ่านคำสั่ง `winget` พร้อมระบบตรวจสอบอัจฉริยะ (ข้ามการติดตั้งหากมีโปรแกรมอยู่แล้ว)
2. **🖨️ ซ่อมแซมระบบปริ้นเตอร์และแชร์ไดร์ฟ (Fix Printer & Share Drive):** สั่งหยุดการทำงานของ Print Spooler, ล้างไฟล์คิวปริ้นเตอร์ที่ค้าง (Clear Queue) และรีสตาร์ท Service ที่เกี่ยวข้องกับการแชร์ไฟล์ (LanmanServer/Workstation)
3. **💻 ตรวจสอบข้อมูลสเปคเครื่อง (Get PC Information):** ดึงข้อมูลสำคัญของระบบอย่างรวดเร็ว เช่น ชื่อเครื่อง (PC Name), ชื่อผู้ใช้ (Username), IP Address, รุ่นของ Windows และพื้นที่ว่างของไดร์ฟ C: เพื่อความสะดวกในการรีโมทซัพพอร์ต
4. **🧹 ทำความสะอาดไฟล์ขยะขั้นลึก (Deep PC Cleaner):** สั่งเทถังขยะ (Recycle Bin), ล้างไฟล์ Temp ของ User และ Windows รวมถึงรีเซ็ตแคชของ Windows Update (SoftwareDistribution) เพื่อแก้ปัญหาอัปเดตติดขัด
5. **🩺 ตรวจสอบสุขภาพระบบ (PC Health Diagnostic):** วิเคราะห์ความสมบูรณ์ของคอมพิวเตอร์โดยเช็คระยะเวลาการเปิดเครื่องค้างไว้ (Uptime), การทำงานของ CPU/RAM, สถานะฮาร์ดดิสก์ และการเชื่อมต่ออินเทอร์เน็ต พร้อมไฮไลท์แจ้งเตือนสีแดงหากพบความผิดปกติ
6. **🌐 ซ่อมแซมและรีเซ็ตเครือข่าย (Network Fixer):** ล้างแคช DNS, คืนค่าและขอรับ IP Address ใหม่ (Release/Renew) รวมถึงรีเซ็ต Winsock catalog เพื่อแก้ปัญหาการเชื่อมต่ออินเทอร์เน็ตหรือเข้าเว็บไม่ได้

## 🚀 วิธีการใช้งาน

สคริปต์นี้เป็นแบบ "Polyglot" (รวม Batch และ PowerShell ไว้ด้วยกัน) ไม่ต้องติดตั้งโปรแกรมใดๆ เพิ่มเติม

1. ดาวน์โหลดไฟล์ `IT-Toolkit-All-In-One.cmd`
2. ดับเบิ้ลคลิกเพื่อรันไฟล์
3. กด `Yes` เมื่อระบบถามหาหน้าต่าง UAC (สคริปต์จะขอสิทธิ์ Administrator โดยอัตโนมัติ)
4. พิมพ์ตัวเลขเมนูที่ต้องการใช้งาน แล้วกด `Enter`

## 🛠️ เทคโนโลยีที่ใช้ (Tech Stack)
* **Language:** PowerShell, Windows Batch Script
* **Package Manager:** Windows Package Manager (Winget)
* **Design:** Polyglot Script (ใช้ Batch เป็นตัวเรียกใช้งาน PowerShell เบื้องหลัง)

---

<a id="english-version"></a>
# 🇬🇧 English Version

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

---

## 👤 Author / ผู้พัฒนา
Developed by **Natdanai patike**
