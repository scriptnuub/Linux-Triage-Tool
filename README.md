# Linux Live Triage & Evidence Collector

## 📌 Objective
A Bash-based incident response tool designed for rapid evidence collection on live Linux systems. This script automates the gathering of volatile data and system logs to assist SOC analysts in identifying the root cause of an intrusion during the "Golden Hour" of an incident.

## 🛠️ Data Collection Features
* **Volatile Data:** Captures active network connections (`netstat`), running processes (`ps`), and open files (`lsof`).
* **Persistence Checks:** Audits `cron` jobs, systemd services, and `~/.ssh/authorized_keys` for unauthorized entries.
* **Log Aggregation:** Automatically archives `/var/log/auth.log`, `/var/log/syslog`, and web server logs.
* **User Activity:** Pulls login history (`last`, `lastb`) and sudoer configurations.

## ⚙️ Usage
1. Transfer the script to a mounted USB drive to avoid tainting host evidence.
2. Grant execution permissions: `chmod +x triage-tool.sh`
3. Run with root privileges: `sudo ./triage-tool.sh`

## ⚠️ Forensic Note
This tool is designed to follow the **Order of Volatility**. It collects memory-resident data first before interacting with the disk to preserve the integrity of the investigation as much as possible.

## How To Run

```bash
# Ensure the script is executable
chmod +x triage.sh

# Run with root privileges to access protected logs
sudo ./triage.sh

## Reports

Runtime reports are generated locally and **not committed to GitHub**.

A sanitized example is provided in:  
`sample_report.txt`
