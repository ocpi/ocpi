This repostory contains the OCPI specification. 

Current work in progress is found in the .md files on the master branch: 
* [Introduction.md](Introduction.md)
* [1. Terminology & data.md](1. Terminology & data.md)
* [2. Protocol and endpoints.md](2. Protocol and endpoints.md)
* [3. Charging locations data exchange.md](3. Charging locations data exchange.md)
* [4. Evse commands.md](4. Evse commands.md)
* [5. Token broadcast between MSP and CPO.md](5. Token broadcast between MSP and CPO.md)
* [6. Session information exchange.md](6. Session information exchange.md)
* [7. Smart charging.md](7. Smart charging.md)
* [8. Status codes.md](8. Status codes.md)

The specification is intended to be finalised module-by-module. Once a  module is finalised, a module will be implemented and tested by the parties cooperating on the specification. The finalisation work for the following module will commence in parellel.

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

