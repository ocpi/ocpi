This repository contains the OCPI specification, latest release: [`OCPI 2.2.1`](https://evroaming.org/app/uploads/2021/11/OCPI-2.2.1.pdf)

The branch with the latest fixes to the 2.2.1 documentation is [`release-2.2.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.2.1-bugfixes)

-The branch with the latest fixes to the 2.2 documentation is [`release-2.2-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.2-bugfixes)

The branch with the latest fixes to the 2.1.1 documentation is [`release-2.1.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.1.1-bugfixes)

The `master` branch always contains the latest official release.

Development of the next version of OCPI, new functionality, is done in the  [ocpi-3 repository](https://github.com/ocpi/ocpi-3/), which is only accessible to Contributors of the [EV Roaming Foundation](https://evroaming.org/how-to-join/).

## Contents

 * [__Version History__](version_history.asciidoc)
 * [__Introduction__](introduction.asciidoc)
   - [Terminology and Definitions](terminology.asciidoc)
   - [Supported Topologies](topology.asciidoc)
 * __Protocol Meta Information__, describes the connections between the parties
   - [Transport and Format](transport_and_format.asciidoc)
   - [Status codes](status_codes.asciidoc)
   - [Version information endpoint](version_information_endpoint.asciidoc)
   - [Credentials & registration](credentials.asciidoc)
 * __Overview of Modules__, each section describes one module.
   - [Locations](mod_locations.asciidoc)
   - [Sessions](mod_sessions.asciidoc)
   - [CDRs](mod_cdrs.asciidoc)
   - [Tariffs](mod_tariffs.asciidoc)
   - [Tokens](mod_tokens.asciidoc)
   - [Commands](mod_commands.asciidoc)
   - [Charging Profiles](mod_charging_profiles.asciidoc)
   - [Hub Client Info](mod_hub_client_info.asciidoc)

 * __Generic Types__, describing all data types that are used by multiple objects
   - [Types](types.asciidoc)
 * [__Changelog__](changelog.asciidoc)

### Current versions

#### Release 2.2.1

Only minor changes, but breaking compatibility with 2.2 in order to support signed data exchange so that parties using OCPI can comply with consumer protection legislation. A more detailed overview is inside [the specification document itself](https://evroaming.org/app/uploads/2021/11/OCPI-2.2.1.pdf).

#### Release 2.2-d2

- Support for Hubs 
  - Message routing headers 
  - Hub Client Info 
- Support Platforms with multiple/different roles, additional roles 
- Charging Profiles 
- based Smart Charging 
- Improvements:
  - CDRs: Credit CDRs, VAT, Calibration law/Eichrecht support, Session_id, AuthorizationReference, CdrLocation, CdrToken
  - Sessions: VAT, CdrToken, How to add a Charging Period
  - Tariffs: Tariff types, Min/Max price, reservation tariff, Much more examples
  - Locations: Multiple Tariffs, Lost of small improvements
  - Tokens: Group_id, energy contract
  - Commands: Cancel Reservation added
- fixes some bugs of 2.1.1

#### Release 2.1.1-d2

- Improvements from rel. 2.0
- Chargepoint commands
- realtime authorization
- fixes some bugs of 2.1 (2.1 is now deprecated)

#### Release 2.0

- Charge Point Exchange Static & Dynamic (with tariffing covering only start/kWh/time)
- Authorization & token data exchange
- Tariffing
- Session Info exchange (cdr & ndr)
- Registration (How to connect) & Security


### Planned releases

#### Release 3.0

- ISO 15118 Plug&Charge
- Eichrecht support
- Performance improvements


## Building Process

The OCPI Build Process has been improved. OCPI 2.0/2.1.1 was in markdown format, and diagrams where Plantuml.

For OCPI 2.2, the text of OCPI has been converted to asciidoc. 
Asciidoc is easier to format the output, and chapter numbering and internal links are much easier to work with.

The Plantuml is no longer converted to PNG images, but the SVG, making them much better readable, and even searchable in the PDF.

In OCPI 2.0 and 2.1.1, the JSON examples contained a lot of mistakes, where outdated compared to the text, or not even valid JSON. 
To prevent issues with the examples in the specification, the examples are not placed in separate JSON files. 
At the moment, the JSON files are check if they are valid JSON.

----
1 Dec 2014 [Draft v4](releases/old/OCPI-Draftv4.pdf) is published
17 June 2015 [Draft v5] is moved to a new branch that will be used as a reference as the OCPI specifications are being redefined and the specifications are restructured in different files, a file per chapter
