#! /usr/bin/env bash

REPORT_FORMAT=$1
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

function main {
	# must have a report type parameter
	[[ -z "$REPORT_FORMAT" ]] && exit 0;
	
	rm -f "$LYNIS_REPORT_PATH/{full,integration,pentest}/*.{html,pdf}";
	dirs=( full integration pentest )

	for dir in "${dirs[@]}"; do
		for file in $(ls "$LYNIS_REPORT_PATH/$dir"); do
			endpoint=$(echo $file | cut -d'.' -f1)
			# HTML format
			if [[ "$REPORT_FORMAT" == "html" || "$REPORT_FORMAT" == "pdf" ]]; then
				cat "$LYNIS_REPORT_PATH/$dir/$file" | ansi2html -at "Lynis Report" -s "osx" > "$LYNIS_REPORT_PATH/$dir/$endpoint.html"
			fi
			# PDF format
			if [[ "$REPORT_FORMAT" == "pdf" ]]; then
				wkhtmltopdf -q "$LYNIS_REPORT_PATH/$dir/$endpoint.html" "$LYNIS_REPORT_PATH/$dir/$endpoint.pdf"
			fi
		done;
	done;
}

main
