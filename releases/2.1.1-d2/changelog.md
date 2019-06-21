# Changelog

## Changes between OCPI 2.1.1 and 2.1.1-d2

Lots of typos in text and examples fixed.

<div><!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ --></div>

| Context (Module / Object)              | Expected Impact: eMSP / CPO | Expected Effort: eMSP / CPO | Description                                                                         
|----------------------------------------|-----------------------------|-----------------------------|------------------------------------------------------------------------------------|
| Commands / CPO POST method             | Minor / Minor               | Minimal / Minimal           | correct incorrect type of response, was: CommandResponseType but should have been: CommandResponse.
| Commands / eMSP POST method            | Minor / Minor               | Minimal / Minimal           | correct incorrect type of request body, was: CommandResponseType but should have been: CommandResponse.
<div><!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ --></div>


## Changes between OCPI 2.1 and 2.1.1

Lots of typos fixed and textual improvements.

The following changes to messages/objects etc.

<div><!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ --></div>

| Context (Module / Object)              | Expected Impact: eMSP / CPO | Expected Effort: eMSP / CPO | Description                                                                         
|----------------------------------------|-----------------------------|-----------------------------|------------------------------------------------------------------------------------|
| CDRs / CDR object                      | Minor / Minor               | Minimal / Minimal           | field: CDR.id is changed from string(15) to string(36). |
| CDRs / CDR object                      | Minor / Minor               | Minimal / Minimal           | field: CDR.auth_id is changed from string(32) to string(36). |
| CDRs / CDR object                      | Minor / Minor               | Minimal / Minimal           | field: Session.stop_date_time is changed from optional (?) to required (1). |
| Commands / ReserveNow object           | Minor / Minor               | Minimal / Minimal           | field: ReserveNow.location_id is changed from string(15) to string(39). |
| Commands / ReserveNow object           | Minor / Minor               | Minimal / Minimal           | field: ReserveNow.evse_uid is changed from string(15) to string(39). |
| Commands / StartSession object         | Minor / Minor               | Minimal / Minimal           | field: StartSession.location_id is changed from string(15) to string(39). |
| Commands / StartSession object         | Minor / Minor               | Minimal / Minimal           | field: StartSession.evse_uid is changed from string(15) to string(39). |
| Commands / StopSession object          | Minor / Minor               | Minimal / Minimal           | field: StopSession.session_id is changed from string(15) to string(36). |
| Commands / UnlockConnector object      | Minor / Minor               | Minimal / Minimal           | field: UnlockConnector.location_id is changed from string(15) to string(39). |
| Commands / UnlockConnector object      | Minor / Minor               | Minimal / Minimal           | field: UnlockConnector.evse_uid is changed from string(15) to string(39). |
| Commands / UnlockConnector object      | Minor / Minor               | Minimal / Minimal           | field: UnlockConnector.connector_id is changed from string(15) to string(36). |
| Locations / CPO GET Object method      | Minor / Minor               | Minimal / Minimal           | parameter: location_id is changed from string(15) to string(39). |
| Locations / CPO GET Object method      | Minor / Minor               | Minimal / Minimal           | parameter: evse_uid is changed from string(15) to string(39). |
| Locations / CPO GET Object method      | Minor / Minor               | Minimal / Minimal           | parameter: connector_id is changed from string(15) to string(36). |
| Locations / eMSP GET method            | Minor / Minor               | Minimal / Minimal           | parameter: location_id is changed from string(15) to string(39). |
| Locations / eMSP GET method            | Minor / Minor               | Minimal / Minimal           | parameter: evse_uid is changed from string(15) to string(39). |
| Locations / eMSP GET method            | Minor / Minor               | Minimal / Minimal           | parameter: connector_id is changed from string(15) to string(36). |
| Locations / eMSP PUT method            | Minor / Minor               | Minimal / Minimal           | parameter: location_id is changed from string(15) to string(39). |
| Locations / eMSP PUT method            | Minor / Minor               | Minimal / Minimal           | parameter: evse_uid is changed from string(15) to string(39). |
| Locations / eMSP PUT method            | Minor / Minor               | Minimal / Minimal           | parameter: connector_id is changed from string(15) to string(36). |
| Locations / Location object            | Minor / Minor               | Minimal / Minimal           | field: Location.id is changed from string(15) to string(39). |
| Locations / EVSE object                | Minor / Minor               | Minimal / Minimal           | field: EVSE.uid is changed from string(15) to string(39). |
| Locations / Connector object           | Minor / Minor               | Minimal / Minimal           | field: Connector.id is changed from string(15) to string(36). |
| Sessions / eMSP GET method             | Minor / Minor               | Minimal / Minimal           | parameter: session_id is changed from string(15) to string(36). |
| Sessions / eMSP PUT method             | Minor / Minor               | Minimal / Minimal           | parameter: session_id is changed from string(15) to string(36). |
| Sessions / Session object              | Minor / Minor               | Minimal / Minimal           | field: Session.id  is changed from string(15) to string(36). |
| Sessions / Session object              | Minor / Minor               | Minimal / Minimal           | field: Session.auth_id length changed from 15 to 36 this was THE bug in 2.1. |
| Sessions / Session object              | Minor / Minor               | Minimal / Minimal           | field: Session.total_cost is changed from required (1) to optional (?). |
| Tariffs / eMSP GET method              | Minor / Minor               | Minimal / Minimal           | parameter: tariff_id is changed from string(15) to string(36). |
| Tariffs / eMSP PUT method              | Minor / Minor               | Minimal / Minimal           | parameter: tariff_id is changed from string(15) to string(36). |
| Tariffs / eMSP DELETE method           | Minor / Minor               | Minimal / Minimal           | parameter: tariff_id is changed from string(15) to string(36). |
| Tariffs / Tariff object                | Minor / Minor               | Minimal / Minimal           | field: Tariff.id length changed from string(15) to string(36). |
| Tokens / CPO GET method                | Minor / Minor               | Minimal / Minimal           | parameter: token_uid is changed from string(15) to string(36). |
| Tokens / CPO PUT method                | Minor / Minor               | Minimal / Minimal           | parameter: token_uid is changed from string(15) to string(36). |
| Tokens / eMSP POST method              | Minor / Minor               | Minimal / Minimal           | parameter: token_uid is changed from string(15) to string(36). |
| Tokens / eMSP POST method              | Minor / Minor               | Minimal / Minimal           | extra optional parameter added: token_type. |
| Tokens / Token object                  | Minor / Minor               | Minimal / Minimal           | field: Token.uid length changed from string(15) to string(36). |
| Tokens / Token object                  | Minor / Minor               | Minimal / Minimal           | field: Token.auth_id length changed from string(32) to string(36). |
| Transport and Format / Response format | Minor / Minor               | Minimal / Minimal           | field: data now allows String as possible type, needed for the commands module. |
<div><!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ --></div>


## Changes between OCPI 2.0 and 2.1

<div><!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ --></div>

| Context (Module / Object)                      | Expected Impact: eMSP / CPO | Expected Effort: eMSP / CPO | Description                                                                         
|------------------------------------------------|-----------------------------|-----------------------------|------------------------------------------------------------------------------------|
| CDRs / CDR object                              | Major / Major               | Minimal / Minimal           | replaced field: "total_usage" with: "total_energy", "total_time" and "total_parking_time"                                                                                           |
| CDRs / CDR object                              | Major / Major               | Minimal / Minimal           | OCPI decimal type is removed and replaced by JSON number.                                                                                                                           |
| CDRs / CDR object                              | Major / Major               | Average / Average           | new field added: "last_updated", GET method filters changed to use this new field instead of start of charging session.                                                             |
| CDRs / CdrDimension class                      | Major / Major               | Minimal / Minimal           | OCPI decimal type is removed and replaced by JSON number.                                                                                                                           |
| CDRs / CdrDimension class                      | Minor / Minor               | Minimal / Minimal           | Generic DimensionType replaced by CdrDimensionType.                                                                                                                                 |
| Credentials / Credentials object               | Minor / Minor               | Minimal / Minimal           | field: "Token" had no max string length, is now set to 64.                                                                                                                          |
| Commands module                                | Optional / Optional         | Large / Large               | added new commands module.                                                                                                                                                          |
| Locations / Location object                    | Average / Optional          | Minimal / Minimal           | new field added: "owner"                                                                                                                                                            |
| Locations / Location object                    | Average / Optional          | Minimal / Minimal           | new field added: "time_zone"                                                                                                                                                        |
| Locations / Location object                    | Minor / Optional            | Average / Average           | new field added: "facilities", a list of new type: [Facility](mod_locations.md#xx-facility-enum)                                                                                    |
| Locations / Location object                    | Minor / Optional            | Average / Average           | new field added: "energy_mix"                                                                                                                                                       |
| Locations / Location object                    | Minor / Minor               | Minimal / Minimal           | new field added: "last_updated"                                                                                                                                                     |
| Locations / EVSE object                        | Minor / Minor               | Minimal / Minimal           | new field added: "last_updated"                                                                                                                                                     |
| Locations / Connector object                   | Minor / Minor               | Minimal / Minimal           | new field added: "last_updated"                                                                                                                                                     |
| Locations / Connector object                   | Minor / Minor               | Minimal / Minimal           | removed field: "status"                                                                                                                                                     |
| Locations / GET list method                    | Optional / Average          | Minimal / Average           | added filters to retrieve only Locations that have been updated between date_to/date_from.                                                                                          |
| Locations / GET object method                  | Optional / Average          | Average / Average           | added functionality to retrieve information about a specific Location, EVSE or Connector from a CPO. This can be useful for eMSPs that require 'real-time' authorization of Tokens. |
| Locations / Capability enum                    | Minor / Optional            | Minimal / Minimal           | added new values to the enum: Capability.                                                                                                                                           |
| Sessions / Session object                      | Major / Major               | Minimal / Minimal           | OCPI decimal type is removed and replaced by JSON number.                                                                                                                           |
| Sessions / Session object                      | Major / Major               | Average / Average           | new field added: "last_updated", GET method filters changed to use this new field instead of start of charging session.                                                             |
| Sessions / eMSP DELETE method                  | Minor / Optional            | Minimal / Minimal           | Session DELETE method is removed.                                                                                                                                                   |
| Tariffs / Tariff object                        | Minor / Optional            | Average / Average           | new field added: "energy_mix"                                                                                                                                                       |
| Tariffs / Tariff object                        | Minor / Minor               | Minimal / Minimal           | new field added: "last_updated"                                                                                                                                                     |
| Tariffs / PriceComponent class                 | Major / Major               | Minimal / Minimal           | OCPI decimal type is removed and replaced by JSON number.                                                                                                                           |
| Tariffs / PriceComponent class                 | Major / Major               | Minimal / Minimal           | OCPI decimal type is removed and replaced by JSON number.                                                                                                                           |
| Tariffs / PriceComponent class                 | Minor / Minor               | Minimal / Minimal           | Generic DimensionType replaced by TariffDimensionType.                                                                                                                              |
| Tariffs / CPO GET method                       | Optional / Average          | Minimal / Average           | added filters to retrieve only Tokens that have been updated between date_to/date_from.                                                                                             |
| Tokens / eMSP POST method                      | Optional / Major            | Large / Large               | added functionality for 'real-time' authorization of Tokens.                                                                                                                        |
| Tokens / Token object                          | Optional / Minor            | Minimal / Average           | new field added: language.                                                                                                                                                          |
| Tokens / Token object                          | Major / Major               | Minimal / Average           | changed field: whitelist_allowed (type: boolean) to whitelist (type: WhitelistType)                                                                                                 |
| Tokens / Token object                          | Minor / Minor               | Minimal / Minimal           | new field added: "last_updated"                                                                                                                                                     |
| Tokens / Token object                          | Optional / Minor            | Minimal / Minimal           | field: "visual_number" is now optional.                                                                                                                                             |
| Tokens / eMSP GET method                       | Average/ Optional           | Average / Minimal           | added filters to retrieve only Tokens that have been updated between date_to/date_from.                                                                                             |
| Version information / Custom Modules           | Optional / Optional         | Average / Average           | added description on how to add custom/customized modules to OCPI.                                                                                                                  |
| Version information / Version class            | Minor / Minor               | Minimal / Minimal           | OCPI Version changed from OCPI decimal to VersionNumber enum.                                                                                                                       |
| Version information / Version details endpoint | Minor / Minor               | Minimal / Minimal           | OCPI Version changed from OCPI decimal to VersionNumber enum.                                                                                                                       |
<div><!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ --></div>
