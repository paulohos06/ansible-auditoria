#! /bin/bash

DATE="$(date +%Y-%m-%dT%H:%M:%SZ)"
LOG_DIR="/opt/lynis_reports/full"
HOSTNAME="$(cat /etc/hostname)"
REPORT="$LOG_DIR/$HOSTNAME-cron-audit-$DATE.txt"

# run lynis
lynis audit system --auditor 'B.E SecureIT' --cronjob > $REPORT
