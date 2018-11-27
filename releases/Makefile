VERSION = 2.2-DRAFT1

TOOL = asciidoctor-pdf
STYLE_DIR = ./style
THEME = -a pdf-style=theme.yml
STYLES_DIR = -a pdf-stylesdir=$(STYLE_DIR)
STYLING = $(THEME) $(STYLES_DIR)

SOURCE = ocpi_merged

ASCIIDOC = $(VERSION)/$(SOURCE).adoc
TARGET = OCPI-$(VERSION).pdf

all: copy merge check gen_pdf

copy: 
	mkdir -p $(VERSION)
	cp ../*.asciidoc $(VERSION)
	cp ../scripts/*.pl $(VERSION)
	cp -R ../data $(VERSION)

merge:
	cd $(VERSION) && ./merge.pl

check:
	cd $(VERSION) && ./check_asciidoc_links.pl $(SOURCE).adoc
	
    
gen_pdf: $(ASCIIDOC)
	  $(TOOL) $(ASCIIDOC) -o $(TARGET) $(STYLING) -a document_version=$(VERSION)
      
clean: clean_pdf

clean_pdf:
	rm -f $(TARGET)
