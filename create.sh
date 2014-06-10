#!/bin/bash

N=1
while read A ; do
 echo $N=$A
 cat example.svg | sed "saSYMBOLa${A}a" > symbols/$N.svg
 # in more recent versions of inkscape, this can be done without a GUI
 inkscape --with-gui --verb EditSelectAll --verb ObjectToPath --verb FileSave --verb FileQuit symbols/$N.svg
# convert -background transparent -density 150 symbols/$N.svg symbols/$N.png
 let N=$N+1
done < all.txt
#mogrify -trim +repage symbols/*.png

rm symbols/49* symbols/36.* symbols/67.*
#cp special/insignia.png symbols/49.png
cp special/insignia.svg symbols/49.svg
#cp special/tux.png symbols/67.png
#cp special/tux.svg symbols/67.svg 
cp special/superman-inverted.svg symbols/67.svg
