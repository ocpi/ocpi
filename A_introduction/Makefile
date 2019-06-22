DOCUMENT_NAME = A_introduction
DOCUMENT_TITLE=Introduction

include ../_common/version
include ../_common/make_common

all: gen_plantuml copy merge check gen_pdf

copy: 
	mkdir -p $(INTERMEDIATE_DIR)
	cp *.asciidoc $(INTERMEDIATE_DIR)
	cp ../_common/*.asciidoc $(INTERMEDIATE_DIR)
	cp ../scripts/check_asciidoc_links.pl $(INTERMEDIATE_DIR)
	cp ../scripts/$(MERGE) $(INTERMEDIATE_DIR)
	cp -R images $(INTERMEDIATE_DIR)
	cp -R plantuml $(INTERMEDIATE_DIR)

gen_plantuml:
	$(PLANTUML_TOOL) -o ../images/ plantuml/*

merge:
	cd $(INTERMEDIATE_DIR) && ./$(MERGE)

check:
	cd $(INTERMEDIATE_DIR) && ./check_asciidoc_links.pl $(SOURCE).adoc

make_pdf: copy merge gen_pdf

gen_pdf: $(ASCIIDOC)
	$(TOOL) $(ASCIIDOC) -o $(TARGET) $(STYLING) -a document_version=$(DOCUMENT_VERSION) -a ocpi_version=$(VERSION) -a ocpi_document=$(DOCUMENT_TITLE)

clean: clean_pdf

clean_pdf:
	rm -f $(TARGET)
