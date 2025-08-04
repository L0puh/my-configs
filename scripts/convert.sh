#!/bin/bash
# converts markdown file to pdf and opens it in zathura

if [ -z "$1" ]; then
  echo "Usage: $0 input.md"
  exit 1
fi

input_file="$1"
filename="$(basename -- "$input_file")"
filename="${filename%.*}"
output_dir="$HOME/storage/outputs"

mkdir -p "$output_dir"
output="${output_dir}/${filename}.pdf"
pandoc "$input_file" -o "$output" --include-in-header=$HOME/.config/my-configs/header.tex
echo "converted $input_file to $output"

zathura $output
