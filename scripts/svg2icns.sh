#!/bin/zsh -e

# Convert svg to apple icon

sizes=(
"16,16x16"
"32,16x16@2x"
"32,32x32"
"64,32x32@2x"
"128,128x128"
"256,128x128@2x"
"256,256x256"
"512,256x256@2x"
"512,512x512"
"1024,512x512@2x"
)

input=$1
name=$(basename "$input" | sed 's/\.[^\.]*$//')
output="$name.iconset"
mkdir -p "./icons/$output"
for params in $sizes; do
  size=$(echo "$params" | cut -d, -f1)
  label=$(echo "$params" | cut -d, -f2)
  svg2png -w "$size" -h "$size" "$input" "./icons/$output/icon_$label.png" || true
done

iconutil -c icns "./icons/$output" || true
# rm -rf "./icons/$output"
