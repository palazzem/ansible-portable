#!/bin/bash
# Maintainer: Emanuele Palazzetti
# Script to build a portable tar.gz Ansible package without requirements
set -ex

# Clean dependencies
rm -rf target/
mkdir -p target/

# Install Ansible in the target folder
pip install -r requirements.txt --no-compile --target ./target/
cp ./target/ansible/cli/scripts/ansible_cli_stub.py ./target/ansible/__main__.py
VERSION=$(PYTHONPATH=./target/ python -c "import ansible; print(ansible.__version__)")

# Cleaning
rm -rf \
  ./target/*.dist-info \
  ./target/*.egg-info \
  ./target/*.gz \
  ./target/*.whl \
  ./target/bin
find ./target/ -path '*/__pycache__/*' -delete
find ./target/ -type d -name '__pycache__' -empty -delete

# Create the final package
tar -C target/ -cvf builds/ansible-$VERSION.tar.gz .
