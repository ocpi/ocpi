command -v perl >/dev/null 2>&1 || { echo >&2 "I require perl but it's not installed.  Aborting."; exit 1; }
command -v pandoc >/dev/null 2>&1 || { echo >&2 "I require pandoc >1.9.2 but it's not installed. Visit http://pandoc.org/.  Aborting."; exit 1; }

RELEASE_DIR=".."
cat $RELEASE_DIR/introduction.md > all.md
echo "" >> all.md
cat $RELEASE_DIR/terminology.md >> all.md
echo "" >> all.md
cat $RELEASE_DIR/mod_locations_and_evses.md >> all.md
echo "" >> all.md
cat $RELEASE_DIR/types.md >> all.md
echo "" >> all.md
cat $RELEASE_DIR/mod_cdrs.md >> all.md
echo "" >> all.md

# correct references to images, etc.
perl -p -i -e "s/\(data\//\($RELEASE_DIR\/data\//g" all.md

# remove section numbering
perl -p -i -e 's/^(#+\s*)(\d\.)*\d\.?\s/\1 /g' all.md

# correct internal links: no filenames; with padding!
perl -p -i -e 's/((\w+\.md)?#\d+(-|_))/" " x (length($1) - 1) . "#"/eg' all.md 

# correct internal links: use dashes instead of underscores
perl -p -i -e 's/(?<=\(#)(\w+)_(\w+)_(\w+)_(\w+)\)/\1-\2-\3-\4)/g' all.md
perl -p -i -e 's/(?<=\(#)(\w+)_(\w+)_(\w+)\)/\1-\2-\3)/g' all.md
perl -p -i -e 's/(?<=\(#)(\w+)_(\w+)\)/\1-\2)/g' all.md

# correct tables
perl -p -i -e 's/<div><!-- //g' all.md
perl -p -i -e 's/ --><\/div>//g' all.md
perl -p -i -e 's/^\|(\s|-)/  /g' all.md
perl -p -i -e 's/\|\s(?=\w)/  /g' all.md
perl -p -i -e 's/\|(?=\w)/ /g' all.md
perl -p -i -e 's/-\|-/-  /g' all.md
perl -p -i -e 's/ \| /   /g' all.md
perl -i -e '$/ = undef; while($all = <>){ $all =~ s/(?<=[\w.!?:])\s*\|(?=\n\s+\w)/\n\n/g; print $all;}' all.md
perl -p -i -e 's/\|(?=\n)//g' all.md

pandoc --number-sections -V geometry:margin=1in --include-in-header ocpi-header.tex --toc -f markdown_github+multiline_tables -t latex all.md -o OCPI_2.0_new.pdf
