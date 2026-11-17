#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
dot -Tpng -Gdpi=180 figures/fig_growingmap.dot -o figures/fig_growingmap.png
pandoc chapters/*.md --from=markdown-implicit_figures --standalone --citeproc \
  --bibliography=references.bib --resource-path=chapters:. \
  --pdf-engine=xelatex -V documentclass=report -V classoption=oneside \
  -V CJKmainfont='Noto Serif CJK JP' -V mainfont='Noto Serif CJK JP' \
  -V monofont='Noto Sans Mono CJK JP' -V geometry:margin=25mm \
  -V fontsize=11pt --top-level-division=chapter --toc \
  -M title='ライフログ情報を用いた三階層生活状態モデル' \
  -M date='2026年11月17日 修正版' \
  -o sample/thesis_updated_20261117.pdf
printf '%s\n' 'OK: sample/thesis_updated_20261117.pdf'
