#!/usr/bin/env bash

main() {
  sudo apt update;
  sudo apt install -y software-properties-common;
  sudo add-apt-repository --yes --update ppa:ansible/ansible;
  sudo apt install -y git python3.8 ansible wget curl ansible-lint wkhtmltopdf poppler-utils
  sudo ln -s /usr/bin/python3 /usr/bin/python;
}

main
