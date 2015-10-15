## Terminology and Data

 * **OCPI** Open Charge Point Interface
 * **NDR** Notification Detail Record
 * **CDR** Charge Detail Record
 * **CPO** Charging Point Operator
 * **eMSP** e-Mobility Service Provider

## Provider and Operator abbreviation
In this model, the provider and the operator play an important role. In order to target the right provider or operator, they need to be known upfront, at least between the cooperating parties. 

In several standards, an issuing authority is mentioned that will keep a central registry of known Providers and Operators. 
At this moment, the following countries have an authority that keeps track of the known providers and operators:

### The Netherlands

The dutch foundation, named [eViolin](http://www.eviolin.nl) keeps the registry for The Netherlands. 

 * The list of operator IDs and provider IDs can be viewed on their website [eViolin/Leden](http://www.eviolin.nl/index.php/leden/). 

### Germany

The BDEW organisation keeps the registry for Germany in their general code number service [bdew-codes.de](https://bdew-codes.de/).

 * [Provider ID Liste](https://bdew-codes.de/Codenumbers/EMobilityId/ProviderIdList) See https://bdew-codes.de/Codenumbers/EMobilityId/ProviderIdList
 * [EVSE Operator ID Liste](https://bdew-codes.de/Codenumbers/EMobilityId/OperatorIdList)  See https://bdew-codes.de/Codenumbers/EMobilityId/OperatorIdList

### Austria

Austrian Mobile Power GmbH maintains a registry for Austria. The list is not public available.
For more information visit [austrian-mobile-power.at](http://austrian-mobile-power.at/tools/id-vergabe/information/)

### Charging topology

The charging topology, as relevant to the eMSP, consists of three entities:

* *Connector* is a specific socket or cable available for the EV to make use of.
* *EVSE* is the part that controls the power supply to a single EV in a single session. An EVSE may provide multiple connectors but only one of these can be active at the same time.
* *Location* is a group of one or more EVSE's that belong together geographically or spatially.

![Topology](data/topology.png)

A Location is typically the exact location of one or more EVSE's, but it can also be the entrance of a parking garage or a gated community. It is up to the CPO to use whatever makes the most sense in a specific situation. Once arrived at the location, any further instructions to reach the EVSE from the Location are stored in the EVSE object itself (such as the floor number, visual identification or manual instructions).


### Variable names

In order to prevent issues with Capitals in variable names, the naming in JSON is not CamelCase but snake_case. All variables are lowercase and include an underscore for a space.


### Data types

When defining the cardinality of a field, the following symbols are used during the document:

| Symbol | Description                     | Type     |
|--------|---------------------------------|----------|
| ?      | An optional object.             | Object   |
| 1      | Required object.                | Object   |
| *      | A list of zero or more objects. | [Object] |
| +      | A list of at least one object.  | [Object] |


#### Decimals

Decimals are formatted as strings following JSON's number format. They are explicitely expressed as strings to make it clear that they should be interpreted as exact decimals and not as floating points or doubles.

Example:

    "0.68"
    "3.1415"

#### DateTime

All timestamps are formatted as string(25) using the combined date and time format from the ISO 8601 standard. The absence of the timezone designator implies a UTC timestamp.


Example:

    2015-06-29T22:39:09+02:00
    2015-06-29T20:39:09Z
    2015-06-29T20:39:09

#### URL's

An URL a string(255) type following the [w3.org spec](http://www.w3.org/Addressing/URL/uri-spec.html).
