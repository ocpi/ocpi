# Release procedure

* create a new directory in `releases/` with the release version as the name, i.e. `2.1`
* copy over all relevant markdown files and other assets (e.g. the data/ directory)
* edit the $RELEASE_PATH and $OUTFILE in releases/make_pdf.sh and run it from the releases directory (!)
** you'll need `pandoc` and `latex`
* check the resulting PDF for formatting errors, etc.
* if you're happy with the result: commit everything and push
* go to https://github.com/ocpi/ocpi/releases and create a new release with the same name

done! 
