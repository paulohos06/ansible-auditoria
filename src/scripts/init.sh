#!/usr/bin/env bash

main() {
  sudo apt update;
  sudo apt install -y software-properties-common;
  sudo add-apt-repository --yes --update ppa:ansible/ansible;
  sudo apt install -y python3.8 ansible wget curl python-is-python3 ansible-lint ansi2html wkhtmltopdf poppler-utils
}

main
