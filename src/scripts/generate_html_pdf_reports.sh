#! /usr/bin/env bash

AUDIT_REPORT_PATH="/home/vagrant/ansible/reports/audit"
LYNIS_REPORT_PATH="/home/vagrant/ansible/reports/lynis"
FRONTPAGE_REPORT="/home/vagrant/ansible/assets/docs/frontpage_report.pdf"

function LynisReports {
	# remove all html and pdf files
	rm -f "$LYNIS_REPORT_PATH/*.{html,pdf}"

	for f in $(ls $LYNIS_REPORT_PATH); do
		hostname=$(echo $f | cut -d'-' -f1)
		cat "$LYNIS_REPORT_PATH/$f" | ansi2html -at "Lynis Report" -s "osx" > "$LYNIS_REPORT_PATH/$hostname-lynis-report.html"
		#echo "$(<$LYNIS_REPORT_PATH/$f)" | xargs ansi2html -at "Lynis Report" -s "osx" > "$LYNIS_REPORT_PATH/$hostname-lynis-report.html"
		wkhtmltopdf -q "$LYNIS_REPORT_PATH/$hostname-lynis-report.html" "$LYNIS_REPORT_PATH/$hostname-lynis-report.pdf"
		#pdfunite $FRONTPAGE_REPORT "$LYNIS_PDF_PATH/$hostname-report.pdf" "$LYNIS_PDF_PATH/$hostname-audit.pdf"
		
	done
}

function AuditReports {
	echo 'friend'
}

LynisReports
