#!/bin/bash

# all.txt contains a TAB separated list of KEY -> TEXT for each key in
# KINESIS_DCS naming convention (i.e. the Kinesis QWERTY name and the
# DCS keycap size).

# TODO this script converts each line into an SVG file

# TODO if all.txt has a full set using WASD naming conventions [1] (R4
#      is top row) then opening wasd.svg will be your printing layout
#      included. Convert to vector-only to remove fonts, and embed all
#      images, before sending. Additional adhoc keys will be needed to
#      complete a Kinesis layout. 105 [2] and 104 [3] layouts are
#      available, I'm using 105 so that I get an extra R1 1.25.
#      Most symbols discovered via [4].

# [1] http://support.wasdkeyboards.com/customer/portal/articles/1366948-keycap-compatibility
# [2] http://support.wasdkeyboards.com/customer/portal/kb_article_attachments/54760/original.svg
# [3] http://support.wasdkeyboards.com/customer/portal/kb_article_attachments/56630/original.svg
# [4] http://xahlee.info/comp/unicode_computing_symbols.html

mkdir symbols 2>/dev/null

cat all.txt | while IFS=$'\t' read N A ; do
 cat example.svg | sed "saSYMBOLa${A}a" > symbols/$N.svg
 # older versions of inkscape need --with-gui
 inkscape --without-gui --verb EditSelectAll --verb ObjectToPath --verb FileSave --verb FileQuit symbols/$N.svg
 #convert -background transparent -density 150 symbols/$N.svg symbols/$N.png
done
#mogrify -trim +repage symbols/*.png

#rm symbols/49* symbols/36.* symbols/67.*
#cp special/insignia.png symbols/49.png
#cp special/insignia.svg symbols/49.svg
#cp special/tux.png symbols/67.png
#cp special/tux.svg symbols/67.svg 
#cp special/superman-inverted.svg symbols/67.svg

cp special/superman-inverted.svg symbols/WIN_R5.svg 

for SVG in symbols/*.svg ; do
    PDF="`echo $SVG | sed 's/.svg/.pdf/'`"
    inkscape "$SVG" --export-pdf="$PDF"
done

xmllint --xinclude wasd-105.svg  > wasd-105-embedded.svg
