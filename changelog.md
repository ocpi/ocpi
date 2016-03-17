## Changelog

### 2.0 to 2.1

<div><!-- ---------------------------------------------------------------------------- --></div>
| Module(s) / Object(s) | Expected Impact | Description                                      |
|---------------------|-----------------|--------------------------------------------------|
|[Locations](mod_locations.md) / [Location](mod_locations.md#31-location-object) | Minor | new field added: "owner" |
|[CDRs](mod_cdrs.md) / [CDR](mod_cdrs.md#31-cdr-object)                          | Major | replaced field: "total_usage" with: "total_energy", "total_time" and "total_parking_time" |
|[Locations](mod_locations.md) / [Location](mod_locations.md#31-location-object) | Minor | new field added: "facilities", a list of new type: [Facility](mod_locations.md#xx-facility-enum) |
|[Locations](mod_locations.md) / [GET object](mod_locations.md#get-object-request-parameters) | Minor | added functionality to retrieve information about a specific Location, EVSE or Connector from a CPO. This can be useful for eMSP that requires on-line checking of Tokens. |
<div><!-- ---------------------------------------------------------------------------- --></div>
