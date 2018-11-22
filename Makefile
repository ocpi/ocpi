TOOL = asciidoctor-pdf
STYLE_DIR = ./releases/style
THEME = -a pdf-style=theme.yml
STYLES_DIR = -a pdf-stylesdir=$(STYLE_DIR)
STYLING = $(THEME) $(STYLES_DIR)

SOURCE = ocpi

ASCIIDOC = $(SOURCE).adoc
TARGET = $(SOURCE).pdf

all: media check_adoc spec

spec: $(SOURCE).adoc
	$(TOOL) $(SOURCE).adoc $(STYLING)


clean: clean_pdf

clean_pdf:
	rm -f $(TARGET)
