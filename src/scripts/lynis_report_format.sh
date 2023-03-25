#! /usr/bin/env bash

REPORT_FORMAT=$1
LYNIS_REPORT_PATH="/home/vagrant/ansible/reports/lynis"
FRONTPAGE_REPORT="/home/vagrant/ansible/assets/docs/frontpage_report.pdf"

function check-file-type {
	if [ -d "$1" ];	then return 1; fi
	return 0;
}


function main {
	# must have a report type parameter
	[[ -z "$REPORT_FORMAT" ]] && exit 0;
	
	#rm -f "$LYNIS_REPORT_PATH/{full,integration,pentest}/*.{html,pdf}";
	dirs=( full integration pentest )

	for dir in "${dirs[@]}"; do
		[ -d "$LYNIS_REPORT_PATH/$dir/html" ] || mkdir -p "$LYNIS_REPORT_PATH/$dir/html"
		[ -d "$LYNIS_REPORT_PATH/$dir/pdf" ] || mkdir -p "$LYNIS_REPORT_PATH/$dir/pdf"

		for file in $(ls "$LYNIS_REPORT_PATH/$dir"); do
			if check-file-type "$LYNIS_REPORT_PATH/$dir/$file"; then
				endpoint=$(echo $file | cut -d'.' -f1)
				# HTML format
				if [[ "$REPORT_FORMAT" == "html" || "$REPORT_FORMAT" == "pdf" ]]; then
					cat "$LYNIS_REPORT_PATH/$dir/$file" | ansi2html -at "Lynis Report" -s "osx" > "$LYNIS_REPORT_PATH/$dir/html/$endpoint.html"
				fi
				# PDF format
				if [[ "$REPORT_FORMAT" == "pdf" ]]; then
					wkhtmltopdf -q "$LYNIS_REPORT_PATH/$dir/html/$endpoint.html" "$LYNIS_REPORT_PATH/$dir/pdf/$endpoint-tmp.pdf"
					pdfunite "$FRONTPAGE_REPORT" "$LYNIS_REPORT_PATH/$dir/pdf/$endpoint-tmp.pdf" "$LYNIS_REPORT_PATH/$dir/pdf/$endpoint.pdf"
					rm -f "$LYNIS_REPORT_PATH/$dir/pdf/$endpoint-tmp.pdf";
				fi
			fi
		done;
	done;
}

main
