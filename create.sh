#!/bin/bash

# all.txt contains a TAB separated list of KEY -> TEXT for each key in DCS naming convention.
# TODO this file converts each line into an SVG file, normalising/centering to ???mm (should the size be in the list?)

# TODO if all.txt has a full set using WASD naming conventions [1] (R4
#      is top row) then opening wasd.svg will be your printing layout
#      included. Convert to vector-only to remove fonts, and embed all
#      images, before sending. Additional adhoc keys will be needed to
#      complete a Kinesis layout. 105 [2] and 104 [3] layouts are
#      available, I'm using 105 so that I get an extra R1 1.25.

# [1] http://support.wasdkeyboards.com/customer/portal/articles/1366948-keycap-compatibility
# [2] http://support.wasdkeyboards.com/customer/portal/kb_article_attachments/54760/original.svg?1431647314
# [3] http://support.wasdkeyboards.com/customer/portal/kb_article_attachments/56630/original.svg?1433981382

cat all.txt | while IFS=$'\t' read A B ; do echo "'$A'='$B'" ; done

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
