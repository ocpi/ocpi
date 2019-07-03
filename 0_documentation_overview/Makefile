include ../_common/version
include ../_common/make_common

SOURCE = documentation_overview.asciidoc
INTERMEDIATE_DIR = ../generated/0_documentation_overview
ASCIIDOC = $(INTERMEDIATE_DIR)/$(SOURCE)
TARGET_DIR = ../releases/$(DOCUMENT_VERSION)
TARGET = $(TARGET_DIR)/OCPI_$(VERSION)_0_documentation_overview.pdf

all: copy check gen_pdf

copy:
	mkdir -p $(INTERMEDIATE_DIR)
	cp *.asciidoc $(INTERMEDIATE_DIR)
	cp ../scripts/check_asciidoc_links.pl $(INTERMEDIATE_DIR)

check: check_asciidoc

check_asciidoc:
	cd $(INTERMEDIATE_DIR) && ./check_asciidoc_links.pl $(SOURCE)

make_pdf: copy gen_pdf

gen_pdf: $(ASCIIDOC)
	$(TOOL) $(ASCIIDOC) -o $(TARGET) $(STYLING) -a document_version=$(DOCUMENT_VERSION) -a ocpi_version=$(VERSION)

clean: clean_pdf clean_intermediate

clean_intermediate:
	rm -r -f $(INTERMEDIATE_DIR)

clean_pdf:
	rm -r -f $(TARGET_DIR)
