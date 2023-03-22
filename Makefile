.SILENT: report

config:
	ansible-playbook src/playbook.yml --tags config

lynis_full_scan:
	ansible-playbook src/playbook.yml --tags lynis_full

report:
	ansible-playbook src/playbook.yml --tags report
	bash src/scripts/generate_html_pdf_reports.sh

	
