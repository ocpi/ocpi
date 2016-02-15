# Release procedure

* create a new directory in `releases/` with the release version as the name, i.e. `2.1`
* copy over all relevant markdown files and other assets (e.g. the data/ directory) 
  * From the root directory do `cp -R data *.md releases/2.1/` where `2.1` is your new folder.
* edit the $PROTOCOL_VERSION and $DOCUMENT_VERSION in releases/make_pdf.sh and run it from the releases directory (!)
  * you'll need `pandoc` (http://pandoc.org/installing.html) and `latex` (https://latex-project.org/ftp.html)
  * you can configure your LATEX_ENGINE according to your latex distribution to one of pdflatex, lualatex, or xelatex.
* check the resulting PDF for formatting errors, etc.
* if you're happy with the result: commit everything and push
* go to https://github.com/ocpi/ocpi/releases and create a new release with the same name

done! 
