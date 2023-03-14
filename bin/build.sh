#!/bin/bash
# Maintainer: Emanuele Palazzetti
# Script to build a portable tar.gz Ansible package without requirements
set -ex

# Clean dependencies
rm -rf target/
mkdir -p target/

# Export Python requirements
# NOTE: Poetry has no options to install in a target folder. See: https://github.com/python-poetry/poetry/issues/1937
pip install poetry
poetry export --without-hashes --format=requirements.txt > requirements.txt

# Install Ansible in the target folder
pip install -r requirements.txt --no-compile --target ./target/
VERSION=$(PYTHONPATH=./target/ python3 -c "import ansible; print(ansible.__version__)")

# Cleaning
rm -rf \
  ./target/*.dist-info \
  ./target/*.egg-info \
  ./target/*.gz \
  ./target/*.whl \
  ./target/bin
find ./target/ -path '*/__pycache__/*' -delete
find ./target/ -type d -name '__pycache__' -empty -delete

# Create the final package and remove stage area
mv target/ ansible-$VERSION/
tar -cvf builds/ansible-$VERSION.tar.gz ansible-$VERSION
rm -rf ansible-$VERSION/
