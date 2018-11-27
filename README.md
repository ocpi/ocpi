This branch contains the development of the next version of OCPI, currently it is expected to be OCPI 2.2.


## Contents

 * [__Version History__](version_history.asciidoc)
 * [__Introduction__](introduction.asciidoc)
   - [Terminology and Definitions](terminology.asciidoc)
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
 * __Generic Types__, describing all data types that are used by multiple objects
   - [Types](types.asciidoc)
 * [__Changelog__](changelog.asciidoc)

<!--
Will be added lated:
- [9. Smart charging](smart_charging.asciidoc)
-->


__Current versions:__

Release 2.0: 

- Charge Point Exchange Static & Dynamic (with tariffing covering only start/kWh/time)
- Authorization & token data exchange
- Tariffing
- Session Info exchange (cdr & ndr)
- Registration (How to connect) & Security

Release 2.1.1:

- Improvements from rel. 2.0
- Chargepoint commands
- realtime authorization
- fixes some bugs of 2.1 (2.1 is now deprecated)


__Planned releases:__

Release 2.2:

- Smart Charging
- Tariffing (advanced/dynamic)


----
1 Dec 2014 [Draft v4](releases/old/OCPI-Draftv4.pdf) is published
17 June 2015 [Draft v5] is moved to a new branch that will be used as a reference as the OCPI specifications are being redefined and the specifications are restructured in different files, a file per chapter

