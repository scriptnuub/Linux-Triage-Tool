# Linux Triage Tool

A lightweight **Linux helpdesk triage script** that collects system, disk, network, and authentication data into a timestamped report.

This tool was built as a **learning project** while transitioning into IT / cybersecurity.  
The script is intentionally readable and documented so I can **learn from my own code** over time.

---

## What This Tool Does

The script (`./triage.sh`) gathers:

- System & kernel info
- Uptime, load, memory, and disk usage
- Network interfaces and routes
- DNS and gateway connectivity tests
- Internet reachability
- Listening ports and services
- Recent authentication-related log entries
- Recent NetworkManager events

All output is saved to a **timestamped report**.

---

## How To Run

```bash
chmod +x triage.sh
./triage.sh
