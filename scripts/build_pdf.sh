#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname -- "${BASH_SOURCE[0]}")/.."

mkdir -p build
work_dir=$(mktemp -d build/.latex.XXXXXXXX)
trap 'rm -rf -- "$work_dir"' EXIT

latexmk -norc -lualatex -interaction=nonstopmode -halt-on-error -file-line-error \
  -outdir="$work_dir" thesis.tex
mv -f -- "$work_dir/thesis.pdf" build/thesis.pdf
printf '%s\n' 'OK: build/thesis.pdf'
