## Changelog

### 2.0 to 2.1

<div><!-- ---------------------------------------------------------------------------- --></div>
| Context                                                                                     | Expected Impact:  eMSP / CPO | Expected Effort: eMSP / CPO | Description                                      |
|---------------------------------------------------------------------------------------------|------------------------------|-------------------------------|--------------------------------------------------|
|[CDRs](mod_cdrs.md) / [CDR](mod_cdrs.md#31-cdr-object)                                       | Major / Major                | Minimal / Minimal          | replaced field: "total_usage" with: "total_energy", "total_time" and "total_parking_time" |
|[Locations](mod_locations.md) / [Location](mod_locations.md#31-location-object)              | Average / Optional           | Minimal / Minimal          | new field added: "owner" |  
|[Locations](mod_locations.md) / [Location](mod_locations.md#31-location-object)              | Average / Optional           | Minimal / Minimal          | new field added: "time_zone" |  
|[Locations](mod_locations.md) / [Location](mod_locations.md#31-location-object)              | Minor / Optional             | Average / Average          | new field added: "facilities", a list of new type: [Facility](mod_locations.md#xx-facility-enum) |
|[Locations](mod_locations.md) / [GET object](mod_locations.md#get-object-request-parameters) | Optional / Average           | Average / Average          | added functionality to retrieve information about a specific Location, EVSE or Connector from a CPO. This can be useful for eMSPs that require 'real-time' authorization of Tokens. |
|[Locations](mod_locations.md) / [Capability](mod_locations.md#42-capability-enum)            | Minor / Optional             | Minimal / Minimal          | added new values to the enum: Capability. |
|[Tokens](mod_tokens.md) / [eMSP POST](mod_tokens.md#222-post-method)                         | Optional / Major             | Large / Large              | added functionality for 'real-time' authorization of Tokens. |
|[Version information](version_information_endpoint.md) / [Custom Modules](version_information_endpoint.md#custom-modules) | Optional / Optional          | Average / Average          | added description on how to add custom/customized modules to OCPI. |
|[Commands](mod_commands)                                                                     | Optional / Optional          | Large / Large              | added new commands module. |
<div><!-- ---------------------------------------------------------------------------- --></div>
