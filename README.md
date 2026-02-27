Linux Live Triage & Evidence Collector
Objective

A Bash-based incident response tool designed for rapid evidence collection on live Linux systems. This script automates the gathering of volatile data and system logs to assist SOC analysts in identifying the root cause of an intrusion during the "Golden Hour" of an incident.
Data Collection Features

    Volatile Data: Captures active network connections, running processes, and open files.

    Persistence Checks: Audits cron jobs, systemd services, and SSH authorized keys.

    Log Aggregation: Automatically archives auth.log, syslog, and web server logs.

    User Activity: Pulls login history and sudoer configurations.

How To Run

1. Prepare
Transfer the script to a mounted USB drive to avoid tainting host evidence.

2. Permissions
Grant execution permissions to the script:

<pre>chmod +x triage.sh</pre>

3. Execute
Run with root privileges to ensure access to protected system logs:

<pre>sudo ./triage.sh</pre>
Reports

Runtime reports are generated locally as a timestamped archive and not committed to GitHub.

    A sanitized example is provided in: sample_report.txt

Forensic & Legal Integrity

    Order of Volatility: This tool is designed to collect memory-resident data first before interacting with the disk to preserve evidence integrity.

    Data Verification: The script automatically generates a SHA256 hash of the final report to ensure the evidence remains untampered throughout the chain of custody.

Job Signals

This project demonstrates the ability to automate critical SOC tasks. It proves technical proficiency in Linux, incident response methodology, and the forensic preservation of evidence.
