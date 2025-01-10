#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <new_color>"
  echo "Example: $0 \"#ff0000\""
  exit 1
fi

new_color=$1

for svg_file in ./*.svg; do
  sed -i "s/fill=\"#\([0-9a-fA-F]\{6\}\)\"/fill=\"$new_color\"/g" "$svg_file"
  echo "Replaced color in $svg_file with $new_color"
done

