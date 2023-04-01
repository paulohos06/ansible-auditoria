#!/usr/bin/env bash

init_debserver() {
  sudo apt update;
  sudo apt install -y software-properties-common;
  sudo add-apt-repository --yes --update ppa:ansible/ansible;
  sudo apt install -y git python3.8 ansible wget curl ansible-lint;
  sudo apt install -y python-is-python3;
  sudo apt install -y aha wkhtmltopdf poppler-utils;
}

init_rhelserver() {
  sudo yum update;
  sudo yum install -y epel-release;
  sudo yum install -y git wget curl python3.8 ansible ansible-lint;
  sudo yum install -y python-is-python3;
  sudo yum install -y aha wkhtmltopdf poppler-utils;
}

init_debserver
