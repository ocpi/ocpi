DOCUMENT_NAME=C_transport_modules
DOCUMENT_TITLE=Transport and Modules

include ../_common/version
include ../_common/make_common

JSON_FILES = $(wildcard $(VERSION)/examples/*.json)

all: gen_plantuml copy merge check gen_pdf

copy:
	mkdir -p $(INTERMEDIATE_DIR)
	cp *.asciidoc $(INTERMEDIATE_DIR)
	cp ../_common/*.asciidoc $(INTERMEDIATE_DIR)
	cp ../scripts/check_asciidoc_links.pl $(INTERMEDIATE_DIR)
	cp ../scripts/$(MERGE) $(INTERMEDIATE_DIR)
	cp -R examples $(INTERMEDIATE_DIR)
	cp -R images $(INTERMEDIATE_DIR)
	cp -R plantuml $(INTERMEDIATE_DIR)

gen_plantuml:
	$(PLANTUML_TOOL) -o ../images/ plantuml/*

merge:
	cd $(INTERMEDIATE_DIR) && ./$(MERGE)

check: check_asciidoc check_json

check_asciidoc:
	cd $(INTERMEDIATE_DIR) && ./check_asciidoc_links.pl $(SOURCE).adoc

check_json: $(JSON_FILES)
	cd $(INTERMEDIATE_DIR)/examples && ./check_json.sh

make_pdf: copy merge gen_pdf

gen_pdf: $(ASCIIDOC)
	$(TOOL) $(ASCIIDOC) -o $(TARGET) $(STYLING) -a document_version=$(DOCUMENT_VERSION) -a ocpi_version=$(VERSION) -a ocpi_document="$(DOCUMENT_TITLE)"

clean: clean_pdf

clean_pdf:
	rm -f $(TARGET)
