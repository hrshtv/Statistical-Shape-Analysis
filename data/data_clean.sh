#!/bin/bash

# Move all *.asf to pointsets/*.txt
for f in *.asf; do 
    mv -- "$f" "pointsets/${f%.asf}.txt"
done

# Move all *.jpg to img/*.jpg
for f in *.jpg; do 
    mv -- "$f" "img/$f"
done

# Clean all .txt files created
for f in pointsets/*.txt; do 
    cat $f | awk 'NR >= 15  && NR <= 74 { print }' > $f
done