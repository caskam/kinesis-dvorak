#!/bin/bash

# all.txt contains a TAB separated list of KEY -> TEXT for each key in
# KINESIS_DCS naming convention (i.e. the Kinesis QWERTY name and the
# DCS keycap size).
#
# If all.txt has a full set using WASD naming conventions [1] (R4 is
# top row) then this script will produce wasd-105-embedded.svg -- your
# printing layout. Note that printers tend to want black text, even
# though they will print it as white on black.
#
# Additional adhoc keys will be needed to complete a Kinesis layout.
# 105 [2] and 104 [3] layouts are available, I'm using 105 so that I
# get an extra R1 1.25. Most symbols discovered via [4].

# [1] http://support.wasdkeyboards.com/customer/portal/articles/1366948-keycap-compatibility
# [2] http://support.wasdkeyboards.com/customer/portal/kb_article_attachments/54760/original.svg
# [3] http://support.wasdkeyboards.com/customer/portal/kb_article_attachments/56630/original.svg
# [4] http://xahlee.info/comp/unicode_computing_symbols.html

mkdir symbols 2>/dev/null

cat all.txt | while IFS=$'\t' read N A ; do
 cat example.svg | sed "saSYMBOLa${A}a" > symbols/$N.svg
 # older versions of inkscape need --with-gui
 inkscape --without-gui --verb EditSelectAll --verb ObjectToPath --verb FileSave --verb FileQuit symbols/$N.svg
done

#cp special/superman.svg symbols/WIN_R5.svg
cp special/superman-colour.svg symbols/WIN_R5.svg 

# for SVG in symbols/*.svg ; do
#     PDF="`echo $SVG | sed 's/.svg/.pdf/'`"
#     inkscape "$SVG" --export-pdf="$PDF"
# done

xmllint --xinclude wasd-105.svg  > wasd-105-embedded.svg

# convert fonts to path

# http://stackoverflow.com/a/7742345/1041691
# inkscape >= 0.49
#inkscape wasd-105-embedded.svg --export-text-to-path --export-plain-svg=wasd-105-embedded-paths.svg
# inkscape < 0.49
inkscape --with-gui --verb EditSelectAllInAllLayers --verb ObjectToPath --verb FileSave --verb FileQuit wasd-105-embedded.svg

# for the README
convert -trim wasd-105-embedded.svg wasd-105-embedded.png
