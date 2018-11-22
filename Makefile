TOOL = asciidoctor-pdf
STYLE_DIR = ../../style
THEME = -a pdf-style=oca-theme.yml
FONT_DIR = -a pdf-fontsdir=$(STYLE_DIR)/font
STYLES_DIR = -a pdf-stylesdir=$(STYLE_DIR)

SOURCE = ocpi

ASCIIDOC = $(SOURCE).adoc
TARGET = $(SOURCE).pdf

all: media check_adoc $(TARGET)

$(TARGET): $(ASCIIDOC)
	$(TOOL) $(ASCIIDOC) $(STYLING)

.PHONY: media

media:
	make -C media

check_adoc:
	perl ../../tools/check_asciidoc_links.pl $(ASCIIDOC)

force:
	$(TOOL) $(ASCIIDOC)

clean: clean_media clean_pdf

clean_pdf:
	rm -f $(TARGET)

clean_media:
	make -C media clean
