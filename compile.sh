#!/bin/sh
#
# compile.sh
# Created:      Jul, 16, 2026 13:42:10 by Thejaka Jayasinghe
set -eu

xelatex main.tex
biber main
explorer.exe main.pdf
