VERSION = 2.2.1-d2
plantuml_tool = java -Xms256m -Xmx512m -jar ../scripts/plantuml.jar -tsvg -nometadata -charset UTF-8

TOOL = asciidoctor-pdf
STYLE_DIR = ./style
THEME = -a pdf-style=theme.yml
STYLES_DIR = -a pdf-stylesdir=$(STYLE_DIR)
STYLING = $(THEME) $(STYLES_DIR)

SOURCE = ocpi_merged

ASCIIDOC = $(VERSION)/$(SOURCE).adoc
TARGET = OCPI-$(VERSION).pdf

JSON_FILES = $(wildcard $(VERSION)/examples/*.json)

all: copy merge check images gen_pdf

copy: 
	mkdir -p $(VERSION)
	cp ../*.asciidoc $(VERSION)
	cp ../scripts/*.pl $(VERSION)
	cp -R ../examples $(VERSION)
	cp -R ../images $(VERSION)
	cp -R ../plantuml $(VERSION)
	cp ../scripts/check_json.sh $(VERSION)/examples

images:
	$(plantuml_tool) -o ../../$(VERSION)/images/ $(VERSION)/plantuml/*

images_current:
	$(plantuml_tool) -o ../images/ ../plantuml/*

merge:
	cd $(VERSION) && ./merge.pl

check: check_asciidoc check_json

check_asciidoc:
	cd $(VERSION) && ./check_asciidoc_links.pl $(SOURCE).adoc

check_json: $(JSON_FILES)
	cd $(VERSION)/examples && ./check_json.sh

make_pdf: copy merge gen_pdf

gen_pdf: $(ASCIIDOC)
	  $(TOOL) $(ASCIIDOC) -o $(TARGET) $(STYLING) -a document_version=$(VERSION)
      
clean: clean_pdf

clean_pdf:
	rm -f $(TARGET)
