#!/usr/bin/env bash
command -v perl >/dev/null 2>&1 || { echo >&2 "I require perl but it's not installed.  Aborting."; exit 1; };
command -v pandoc >/dev/null 2>&1 || { echo >&2 "I require pandoc >1.9.2 but it's not installed. Visit http://pandoc.org/.  Aborting."; exit 1; };

alias pandoc='pandoc +RTS -V0 -RTS'

#############################################
#############################################
# adjust these before you release
PROTOCOL_VERSION="2.1.1";
DOCUMENT_VERSION="${PROTOCOL_VERSION}-d2";
OUTFILE="OCPI_${DOCUMENT_VERSION}.pdf";
RELEASE_DATE=$(date +%d.%m.%Y);
RELEASE_DIR=${DOCUMENT_VERSION};
LATEX_ENGINE="pdflatex";
#############################################
#############################################

cat $RELEASE_DIR/version_history.md > all.md;
echo "" >> all.md;
cat $RELEASE_DIR/introduction.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/terminology.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/transport_and_format.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/status_codes.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/version_information_endpoint.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/credentials.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/mod_locations.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/mod_sessions.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/mod_cdrs.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/mod_tariffs.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/mod_tokens.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/mod_commands.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/types.md >> all.md;
echo "" >> all.md;
cat $RELEASE_DIR/changelog.md >> all.md;
echo "" >> all.md;

# correct references to images, etc.
perl -p -i.bak -e "s/\(data\//\($RELEASE_DIR\/data\//g" all.md;

# remove section numbering
perl -p -i.bak -e 's/^(#+\s*)(\d+\.)*\d+\.?\s/\1 /g' all.md

# correct internal links: no filenames; with padding!
perl -p -i.bak -e 's/((\w+\.md)?#(\d+(-|_))?)(?=\w)/" " x (length($1) - 1) . "#"/eg' all.md 

# correct internal links: use dashes instead of underscores
perl -p -i.bak -e 's/(?<=\(#)(\w+)_(\w+)_(\w+)_(\w+)\)/\1-\2-\3-\4)/g' all.md
perl -p -i.bak -e 's/(?<=\(#)(\w+)_(\w+)_(\w+)\)/\1-\2-\3)/g' all.md
perl -p -i.bak -e 's/(?<=\(#)(\w+)_(\w+)\)/\1-\2)/g' all.md

# translate MD tables to pandoc 'multiline' tables
perl -p -i.bak -e 's/<div><!-- //g' all.md
perl -p -i.bak -e 's/ --><\/div>\r?\n//g' all.md
perl -p -i.bak -e 's/^\|[\s-:]/  /g' all.md
perl -p -i.bak -e 's/\|\s(?=\w)/  /g' all.md
perl -p -i.bak -e 's/\|(?=\w)/ /g' all.md
perl -p -i.bak -e 's/[-:]\|[-:]/-  /g' all.md
perl -p -i.bak -e "s/ \| (?=[^\r\n])/   /g" all.md
perl -i.bak -e '$/ = undef; while($all = <>){ $all =~ s/(?<=[\w.!?:\]\)\$*"`~])\s*\|\s*(?=\r?\n\s+[\[\w?1*+>])/\n\n/g; print $all;}' all.md
perl -p -i.bak -e 's/\|\s*(?=\r?\n)//g' all.md

pandoc \
   +RTS -V0 -RTS \
   --template=ocpi.latex \
  -V fontfamily:"arev" -V fontsize:8pt --number-sections \
  -V geometry:margin=1in -V papersize:"a4paper" -V documentclass:"extarticle" \
  -V title-meta:"Open Charge Point Interface $PROTOCOL_VERSION" -V title:"OCPI $PROTOCOL_VERSION" \
  -V subtitle:"Open Charge Point Interface $PROTOCOL_VERSION, document version: $DOCUMENT_VERSION"\
  -V author:"https://github.com/ocpi" \
  -V author-meta:"OCPI group" -V date:"$RELEASE_DATE" \
  --include-in-header ocpi-header.tex --toc -f markdown_github+multiline_tables -t latex all.md -o "$OUTFILE" --latex-engine="$LATEX_ENGINE"
