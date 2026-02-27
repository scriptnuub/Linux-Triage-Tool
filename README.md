# Linux Live Triage & Evidence Collector

## 📌 Objective
A Bash-based incident response tool designed for rapid evidence collection on live Linux systems. This script automates the gathering of volatile data and system logs to assist SOC analysts in identifying the root cause of an intrusion during the "Golden Hour" of an incident.

## 🛠️ Data Collection Features
* **Volatile Data:** Captures active network connections (`netstat`), running processes (`ps`), and open files (`lsof`).
* **Persistence Checks:** Audits `cron` jobs, systemd services, and `~/.ssh/authorized_keys` for unauthorized entries.
* **Log Aggregation:** Automatically archives `/var/log/auth.log`, `/var/log/syslog`, and web server logs.
* **User Activity:** Pulls login history (`last`, `lastb`) and sudoer configurations.

## ⚙️ How To Run

1. **Prepare:** Transfer the script to a mounted USB drive to avoid tainting host evidence.
2. **Permissions:** Grant execution permissions to the script:
   ```bash
   chmod +x triage.sh

    Execute: Run with root privileges to ensure access to protected system logs:
    Bash

    sudo ./triage.sh

📄 Reports

Runtime reports are generated locally as a timestamped archive and not committed to GitHub.

    A sanitized example is provided in: sample_report.txt

⚠️ Forensic & Legal Integrity

    Order of Volatility: This tool is designed to collect memory-resident data first before interacting with the disk to preserve evidence integrity.

    Data Verification: The script automatically generates a SHA256 hash of the final report to ensure the evidence remains untampered throughout the chain of custody.
