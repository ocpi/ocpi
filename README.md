This repository contains the OCPI specification, developed by the [EV Roaming Foundation](https://evroaming.org/). The latest release is [`OCPI 2.3.0`](https://evroaming.org/wp-content/uploads/2025/02/OCPI-2.3.0.pdf).

The branch with the lastest fixes to the 2.3.0 documentation is [`release-2.3.0-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.3.0-bugfixes)

The branch with the latest fixes to the 2.2.1 documentation is [`release-2.2.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.2.1-bugfixes)

-The branch with the latest fixes to the 2.2 documentation is [`release-2.2-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.2-bugfixes)

The branch with the latest fixes to the 2.1.1 documentation is [`release-2.1.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.1.1-bugfixes)

The `master` branch always contains the latest official release.

Development of the next version of OCPI, new functionality, is done in the  [ocpi-3 repository](https://github.com/ocpi/ocpi-3/), which is only accessible to Contributors of the [EV Roaming Foundation](https://evroaming.org/how-to-join/).

More background on OCPI, its development and its contributors can be found on the EV Roaming Foundation website.

## Building Process

The OCPI Build Process has been improved. OCPI 2.0/2.1.1 was in markdown format, and diagrams where Plantuml.

For OCPI 2.2, the text of OCPI has been converted to asciidoc. 
Asciidoc is easier to format the output, and chapter numbering and internal links are much easier to work with.

The Plantuml is no longer converted to PNG images, but the SVG, making them much better readable, and even searchable in the PDF.

In OCPI 2.0 and 2.1.1, the JSON examples contained a lot of mistakes, where outdated compared to the text, or not even valid JSON. 
To prevent issues with the examples in the specification, the examples are not placed in separate JSON files. 
At the moment, the JSON files are check if they are valid JSON.
