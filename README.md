# Linux Triage Tool

A lightweight **Linux helpdesk triage script** that collects system, disk, network, and authentication data into a timestamped report.

This tool was built as a **learning project** while transitioning into IT / cybersecurity.  
The script is intentionally readable so I can **learn from my own code** over time.

---

## What This Tool Does

The script (`./triage.sh`) gathers:

- System & kernel information  
- Uptime, load, memory, and disk usage  
- Network interfaces and routing table  
- DNS and gateway connectivity tests  
- Internet reachability check  
- Listening ports and running services  
- Recent authentication-related log entries  
- Recent NetworkManager events  

All output is saved to a **timestamped report** for later review.

---

## How To Run

```bash
chmod +x triage.sh
./triage.sh


## Reports

Runtime reports are generated locally and **not committed to GitHub**.

A sanitized example is provided in:  
`sample_report.txt`
