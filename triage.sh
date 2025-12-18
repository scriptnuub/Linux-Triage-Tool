#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "[ERROR] Line $LINENO failed: $BASH_COMMAND" >&2' ERR

# ---------- Config ----------
REPORT_DIR="$HOME/arsenal/reports"
HOST="$(hostname -s)"
TS="$(date +'%Y-%m-%d_%H%M%S')"
REPORT_FILE="$REPORT_DIR/triage_${HOST}_${TS}.txt"

mkdir -p "$REPORT_DIR"

# Log EVERYTHING (stdout + stderr) to screen + report file
exec > >(tee -a "$REPORT_FILE") 2>&1

# ---------- Helpers ----------
section() {
  echo
  echo "[$1]"
}

run() {
  # Usage: run "description" command [args...]
  local desc="$1"; shift
  echo "- $desc"
  "$@" || true
}

# Use sudo only if available; otherwise run without it
SUDO=""
if command -v sudo >/dev/null 2>&1; then
  SUDO="sudo"
fi

# ---------- Header ----------
echo "=============================="
echo " Linux Triage Report"
echo " Host: $HOST"
echo " Time: $(date)"
echo " Report: $REPORT_FILE"
echo "=============================="

# ---------- System ----------
section "SYSTEM"
run "Kernel / OS info" uname -a
run "Uptime + load" uptime

section "CPU/RAM"
run "Memory usage" free -h

section "DISK"
run "Disk usage (human + filesystem type)" df -hT

section "DISK - TOP DIRS under / (may take a moment)"
if [[ -n "$SUDO" ]]; then
  echo "- Top directories under /"
  $SUDO du -xhd1 / 2>/dev/null | sort -hr | head -n 15 || true
else
  echo "- sudo not available; skipping deep / disk breakdown"
fi

# ---------- Network ----------
section "NETWORK - INTERFACES"
run "Interfaces (brief)" ip -br a

section "NETWORK - ROUTES"
run "Routing table" ip r

# ---------- DNS ----------
section "DNS"
DNS_SERVER="$(awk '/^nameserver/{print $2; exit}' /etc/resolv.conf 2>/dev/null || true)"
echo "- DNS server: ${DNS_SERVER:-none-found}"

if [[ -n "${DNS_SERVER:-}" ]]; then
  run "DNS resolution test (google.com)" dig @"$DNS_SERVER" google.com +time=2 +tries=1 +short
else
  echo "- No DNS server found in /etc/resolv.conf"
fi

# ---------- Gateway ----------
section "GATEWAY"
GATEWAY="$(ip r 2>/dev/null | awk '/default/{print $3; exit}' || true)"
echo "- Gateway: ${GATEWAY:-none-found}"

if [[ -n "${GATEWAY:-}" ]]; then
  run "Ping gateway (2 packets)" ping -c 2 -W 1 "$GATEWAY"
else
  echo "- No default gateway route found."
fi

# ---------- Internet ----------
section "INTERNET"
# Simple sanity check: grab only first header line
HTTP_LINE="$(curl -I --max-time 5 https://example.com 2>/dev/null | head -n 1 || true)"
if [[ -n "$HTTP_LINE" ]]; then
  echo "- $HTTP_LINE"
else
  echo "- HTTP test failed"
fi

# ---------- Local exposure ----------
section "LISTENING PORTS"
run "Listening TCP/UDP sockets + process info" ss -tulpen

# ---------- Logs ----------
section "AUTH - LAST 15 (journal)"

JCMD="journalctl -n 200 --no-pager"
[[ -n "$SUDO" ]] && JCMD="$SUDO $JCMD"

$JCMD \
  | grep -Ei "sshd|failed password|invalid user|authentication failure|sudo.*COMMAND=" \
  | tail -n 15 || true

section "NETWORKMANAGER - LAST 15 LOG LINES"
if [[ -n "$SUDO" ]]; then
  run "NetworkManager journal" $SUDO journalctl -u NetworkManager -n 15 --no-pager
else
  run "NetworkManager journal" journalctl -u NetworkManager -n 15 --no-pager
fi

# ---------- Done ----------
echo
echo "DONE. Report saved to: $REPORT_FILE"
