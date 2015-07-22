This repostory contains the OCPI specification.

Current work in progress is found in the .md files on the master branch:
* [Introduction](introduction.md)
* [1. Terminology & data](terminology.md)
* [2. Protocol and endpoints](protocol.md)
* [3. Version information endpoints](versions.md)
* [4. Credentials & registration](credentials.md)
* [5. Locations & EVSE's](locations.md)
* [A. Status codes](status_codes.md)

Will be added lated:
* [6. Evse commands.md](commands.md)
* [7. Token broadcast between MSP and CPO.md](tokens.md)
* [8. Session information exchange.md](sessions.md)
* [9. Smart charging.md](smart_charging.md)

The specification will be finalised module-by-module. Once a module is finalised it will be implemented and tested by the parties cooperating on the specification. The finalisation work for the following module will commence in parellel.

This is the schedule for finalising all modules:

Release 2.0 (expected participants: BeCharged, TNM, LMS, EVB, GFX and, later, E-laad):
- Charge Point Exchange Static & Dynamic (with tariffing covering only start/kWh/time)
- Registration (How to connect) & Security
- Planning (to be confirmed after full impact assessment by parties):
* Spec ready; 3 July 2015
* Implementation ready: 15 August 2015
* Testing ready: 31 August 2015
* Release date (to production): 1 September 2015

Release 2.1:
- Improvements from rel. 1
- Tariffing (advanced/dynamic)
- Session Info exchange (cdr & ndr)
* Spec ready: 31 August 2015
* Implementation ready: 30 September
* Testing ready: 15 October
* Release date (to production): 16 October

Release 2.2 (participants: rel. 2 participants + ?):
- Chargepoint commands (no authorisation)

Release 2.3 (participants: rel. 3 participants + ?):
- Authorisation & token data exchange

Release 2.4:
- Smart Charging


----
1 Dec 2014 [Draft v4](releases/OCPI-Draftv4.pdf) is published
17 June 2015 [Draft v5] is moved to a new branch that will be used as a reference as the OCPI specifications are being redefined and the specifications are restructured in different files, a file per chapter

