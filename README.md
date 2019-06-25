This repository contains the OCPI specification, latest release: [`OCPI 2.1.1-d2`](https://github.com/ocpi/ocpi/releases/download/2.1.1-d2/OCPI_2.1.1-d2.pdf)

The branch with the latest fixes to the 2.1.1-d2 documentation is [`release-2.1.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.1.1-bugfixes)

The `master` branch always contains the latest official release.

Development of the next version of OCPI, new functionality, is done in the  [`develop`](https://github.com/ocpi/ocpi/tree/develop) branch: [`OCPI 2.2 is now Release Candidate 2`](https://github.com/ocpi/ocpi/releases/download/2.2-RC2/OCPI-2.2-RC2.pdf)

## Contents

 * [__Version History__](version_history.md)
 * [__Introduction__](introduction.md)
   - [Terminology and Definitions](terminology.md)
 * __Protocol Meta Information__, describes the connections between the parties
   - [Transport and Format](transport_and_format.md)
   - [Status codes](status_codes.md)
   - [Version information endpoint](version_information_endpoint.md)
   - [Credentials & registration](credentials.md)
 * __Overview of Modules__, each section describes one module.
   - [Locations](mod_locations.md)
   - [Sessions](mod_sessions.md)
   - [CDRs](mod_cdrs.md)
   - [Tariffs](mod_tariffs.md)
   - [Tokens](mod_tokens.md)
   - [Commands](mod_commands.md)
 * __Generic Types__, describing all data types that are used by multiple objects
   - [Types](types.md)
 * [__Changelog__](changelog.md)

<!--
Will be added lated:
* [9. Smart charging.md](smart_charging.md)
-->


__Current versions:__

Release 2.1.1-d2:

- Improvements from rel. 2.0
- Chargepoint commands
- realtime authorization
- fixes some bugs of 2.1 (2.1 is now deprecated)

Release 2.0: 

- Charge Point Exchange Static & Dynamic (with tariffing covering only start/kWh/time)
- Authorization & token data exchange
- Tariffing
- Session Info exchange (cdr & ndr)
- Registration (How to connect) & Security


__Planned releases:__

Release 2.2:

- Smart Charging
- Tariffing (advanced/dynamic)


----
1 Dec 2014 [Draft v4](releases/old/OCPI-Draftv4.pdf) is published
17 June 2015 [Draft v5] is moved to a new branch that will be used as a reference as the OCPI specifications are being redefined and the specifications are restructured in different files, a file per chapter
