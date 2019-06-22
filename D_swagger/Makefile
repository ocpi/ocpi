DOCUMENT_NAME=D_swagger
DOCUMENT_TITLE=Swagger

include ../_common/version
include ../_common/make_common

all: copy merge check images gen_pdf zip_swagger

copy:
	mkdir -p $(INTERMEDIATE_DIR)
	cp *.asciidoc $(INTERMEDIATE_DIR)
	cp ../_common/*.asciidoc $(INTERMEDIATE_DIR)
	cp ../scripts/check_asciidoc_links.pl $(INTERMEDIATE_DIR)
	cp ../scripts/$(MERGE) $(INTERMEDIATE_DIR)

merge:
	cd $(INTERMEDIATE_DIR) && ./$(MERGE)

check:
	cd $(INTERMEDIATE_DIR) && ./check_asciidoc_links.pl $(SOURCE).adoc

zip_swagger:
	cd Swagger && zip -r9 ../$(TARGET_DIR)/OCPI_$(VERSION)_$(DOCUMENT_NAME).zip *.*

make_pdf: copy merge gen_pdf

gen_pdf: $(ASCIIDOC)
	$(TOOL) $(ASCIIDOC) -o $(TARGET) $(STYLING) -a document_version=$(DOCUMENT_VERSION) -a ocpi_version=$(VERSION) -a ocpi_document="$(DOCUMENT_TITLE)"

clean: clean_pdf

clean_pdf:
	rm -f $(TARGET)
