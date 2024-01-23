#!/bin/bash
set -e

sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive  apt-get install --no-install-recommends -y \
	texlive-bibtex-extra \
	texlive-latex-extra \
	texstudio
