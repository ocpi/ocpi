# _Locations and EVSEs_ business object

*General description of the business object*

The location object lives in the operators backend system.



## 1. Inheritances

### 1.1 Service Provider Inheritors

*Describe the purpose and singularity of this inheritor.*

Each service provider can hold one inheritance of the locations objects
their customers have access to.




## 2. Flow and Lifecycle

*Describe the status of the objects, how it is created and destroyed,
when and through which action it gets inherited. Name the owner. Explain
the purpose.*


![Lifecycle][location-lifecycle]



## 3. Interfaces and endpoints

*Explain which interfaces are available and which party should implement
which one.*


### 3.1 Charging Platform Operator Interface

*Describe the interface in detail.*

Endpoint structure `/<path>/<role>/<version>/locations`

Example: `/ocpi/cpo/2.0/locations`

##### Methods

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | Fetch all available locations and EVSE's.            |
| POST     | n/a                                                  |
| PUT      | n/a                                                  |
| PATCH    | n/a                                                  |
| DELETE   | n/a                                                  |


##### Data

The endpoint returns an object of two seperate lists: one list of available locations and one list of available EVSEs.

| Property  | Type        | Card. | Description                              |
|-----------|-------------|-------|------------------------------------------|
| locations | Location    | +     | List of all locations with valid EVSE's. |
| evses     | EVSE        | +     | List of all valid EVSE's.                |



#### 3.1.1 __GET__ Method

Fetch information about all available locations and EVSE's at this CPO.

Any older information that is not specified in the message is considered as no longer valid.

Each object must contain all required fields. Fields that are not specified may be considered as null values.


##### Example

```json
{
  "locations": [
    {
      "id": "LOC1",
      "type": "on_street",
      "name": "Gent Zuid",
      "address": "F.Rooseveltlaan 3A",
      "city": "Gent",
      "postal_code": "9000",
      "country": "BE",
      "coordinates": {"latitude": "3.72994", "longitude": "51.04759"},
      "operator": {"name": "BeCharged"}
    }
  ],
  "evses": [
  {
      "id": "BE-BEC-E041503001",
      "location_id": "LOC1",
      "status": "AVAILABLE",
      "capabilities": [
        "RESERVABLE"
      ],
      "connectors": [
        {
          "id": "1",
          "standard": "IEC-62196-T2",
          "format": "CABLE",
          "power_type": "AC_3_PHASE",
          "voltage": 220,
          "amperage": 16,
          "price_schemes": [
            {
              "default": 1,
              "expiry_date": "2020-12-31T23:59:59Z",
              "start_date": "2010-01-01T00:00:00Z",
              "tariff": [
                {
                  "currency": "EUR",
                  "price_untaxed": 0.1936,
                  "pricing_unit": "kwhtoev",
                  "tariff_id": "kwrate",
                  "display_text": [
                    {
                      "language": "nl",
                      "text": "Standaard Tarief"
                    },
                    {
                      "language": "en",
                      "text": "Standard Tariff"
                    }
                  ]
                }
              ],
              "display_text": [
                {
                  "language": "nl",
                  "text": "Standaard Tarief"
                },
                {
                  "language": "en",
                  "text": "Standard Tariff"
                }
              ]
            },
            {
              "default": 0,
              "expiry_date": "2020-12-31T23:59:59Z",
              "start_date": "2010-01-01T00:00:00Z",
              "tariff": [
                {
                  "currency": "EUR",
                  "price_untaxed": 0.1536,
                  "pricing_unit": "kwhtoev",
                  "tariff_id": "kwrate",
                  "display_text": [
                    {
                      "language": "nl",
                      "text": "eMSP Tarief"
                    },
                    {
                      "language": "en",
                      "text": "eMSP Tariff"
                    }
                  ]
                }
              ],
              "display_text": [
                {
                  "language": "nl",
                  "text": "eMSP Tarief"
                },
                {
                  "language": "en",
                  "text": "eMSP Tariff"
                }
              ]
            }
          ]
        },
        {
          "id": "2",
          "standard": "IEC-62196-T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "voltage": 220,
          "amperage": 16,
          "price_schemes": [
            {
              "default": 1,
              "expiry_date": "2020-12-31T23:59Z",
              "start_date": "2010-01-01T00:00Z",
              "tariff": [
                {
                  "currency": "EUR",
                  "price_untaxed": 0.1936,
                  "pricing_unit": "kwhtoev",
                  "tariff_id": "kwrate",
                  "display_text": [
                    {
                      "language": "nl",
                      "text": "Standaard Tarief"
                    },
                    {
                      "language": "en",
                      "text": "Standard Tariff"
                    }
                  ]
                }
              ],
              "display_text": [
                {
                  "language": "nl",
                  "text": "Standaard Tarief"
                },
                {
                  "language": "en",
                  "text": "Standard Tariff"
                }
              ]
            }
          ]
        }
      ],
      "physical_number": 1,
      "floor_level": "-1"
    },
    {
      "id": "BE-BEC-E041503002",
      "location_id": "LOC1",
      "status": "reserved",
      "capabilities": [
        "RESERVABLE"
      ],
      "connectors": [
        {
          "id": "1",
          "standard": "IEC-62196-T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "voltage": 220,
          "amperage": 16,
          "price_schemes": [
            {
              "default": 1,
              "expiry_date": "2020-12-31T23:59:59Z",
              "start_date": "2010-01-01T00:00:00Z",
              "tariff": [
                {
                  "currency": "EUR",
                  "price_untaxed": 0.1936,
                  "pricing_unit": "kwhtoev",
                  "tariff_id": "kwrate",
                  "display_text": [
                    {
                      "language": "nl",
                      "text": "Standaard Tarief"
                    },
                    {
                      "language": "en",
                      "text": "Standard Tariff"
                    }
                  ]
                }
              ],
              "display_text": [
                {
                  "language": "nl",
                  "text": "Standaard Tarief"
                },
                {
                  "language": "en",
                  "text": "Standard Tariff"
                }
              ]
            },
          ]
        }
      ],
      "physical_number": 2,
      "floor_level": -2
    }
  ]
}
```


### 3.2 Service Provider Interface

*Describe the interface in detail.*

Endpoint structure `/<path>/<role>/<version>/locations`

Example: `/ocpi/emsp/2.0/locations`

##### Methods

| Method                        | Description                                          |
| ----------------------------- | ---------------------------------------------------- |
| GET                           | n/a                                                  |
| POST                          | n/a                                                  |
| [PUT](#3_2_1_PUT_Method)      | Push all available locations and EVSE's to the eMSP, similar to the GET request to the CPO platform but in the other direction. |
| [PATCH](#3_2_2_PATCH_Method)  | Notify the eMSP of partial updates to locations and EVSE's (such as the status). |
| DELETE                        | n/a  _(use PATCH)_                                    |

##### Data

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
| locations | Location    | *     | List of locations.             |
| evses     | EVSE        | *     | List of EVSE's.                |


#### 3.2.1 __PUT__ Method

Fully synchronise the eMSP by pushing all available locations and EVSEs. This is the exact equivalent to a GET request initiated by the eMSP to the CPO endpoint.

Any location or EVSE that is not specified in the message is considered as no longer valid. Each object must contain all required fields. Fields that are not specified may be considered as null values or their default values if specified in the OCPI protocol.


#### 3.2.2 __PATCH__ Method

Update messages are similar to synchronisation messages except that only the object id is required. Unlike the PUT method, only the locations and fields that are updated are specified and any fields or objects that are not specified in the update message are considered unchanged.

##### Example: a simple status update

This is the most common type of update message to notify eMSP's that an EVSE is now occupied.

```json
{
	"evses": [
		{
			"id": "BE-BEC-E041503001",
			"status": "CHARGING",
		}
	]
}
```


##### Example: advanced update

In this example the name of the location is updated and connector 2 of EVSE *BE-BEC-E041503001* receives a new pricing scheme. Note that since the connectors property is atomic, we also have to specify the information for connector 1.

```json
{
	"locations": [
		{
			"id": "LOC1",
			"name": "Interparking Gent Zuid",
		}
	],
	"evses": [
		{
			"id": "BE-BEC-E041503001",
			"status": "AVAILABLE",
			"connectors": [
				{
					"id": "1",
                    "standard": "IEC-62196-T2",
                    "format": "CABLE",
					"price": PRICINGSCHEMES
				},
				{
					"id": "2",
                    "standard": "IEC-62196-T2",
                    "format": "SOCKET",
					"price": NEW_PRICINGSCHEMES
				}
			]
		}
	]
}
```

##### Example: add an EVSE

To add an *EVSE* or a *Location*, simply put the full object in an update message, including all its required fields. Since the id is new, the receiving party will know that it is a new object. The new object should be processed in the same way as in a synchronisation message. When not all required fields are specified, the object may be discarded.

```json
{
	"evses": [
		{
			"evse_id": "BE-BEC-E041503003",
			"location_id": "LOC1",
			"STATUS": "AVAILABLE",
			"capabilities": ["RESERVABLE"],
			"connectors": [
				{
					"id": "1",
                    "standard": "IEC-62196-T2",
                    "format": "SOCKET",
					"price_schemes": PRICINGSCHEMES
				}
			],
			"physical_number": 3,
			"floor": -1,
			"valid_from": "2015-05-21T10:00:00+0200"
		}
	]
}
```

##### Example: delete an EVSE

An EVSE can be deleted by updating its *valid_until* property.

```json
{
	"evses": [
		{
			"id": "BE-BEC-E041503001",
			"valid_until": "2015-04-27T13:00:00+0200"
		}
	]
}
```



## 4. Object description

*Describe the structure of this object.*


### 4.1 Location Object

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |



### 4.2 EVSE Object

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |




## 5. Data types

*Describe all datatypes used in this object*

### Object Template

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |


### Enum Template

| Value     | Description                                          |
| --------- | ---------------------------------------------------- |
|           |                                                      |
|           |                                                      |


---







## Appendix: Figures

### Lifecycle

![Lifecycle][location-lifecycle]
[location-lifecycle]: http://plantuml.com:80/plantuml/svg/ZP713e8m44Jl_OeDT_a0OaZ06FKa1pnvMij6Qx0qPJ7uzu94Wr2KMzEPpBx96BIif3Ae6Rp4gXlQ1-nFLvBi2TCNT_f2LZ5gIH3zq69FYECY7AK5i9IMa2aKA5dTczVueXZ-G9lqVJg0v93sCWPW_oFY9cApdefe-S7tVQWqgnmgapMM4j0OGjiAhtg5gr_d3Lq4XQD5bAwsOeRvpTl7oWk9h0eDP-8ICig9AVlGrIwwpkIagwVeCfhUgg_DsA1sbvfAQMPu0W00 "Lifecycle"


#### Source:

<pre>
<code>
@startuml
participant "Primary Object"
participant "Inheritance A"
participant "Inheritance B"

[-> "Primary Object": <create>
activate "Primary Object"

"Primary Object" -> "Inheritance A": PUT
activate "Inheritance A"

"Primary Object" -> "Inheritance B": GET
activate "Inheritance B"

 ... until updates appear ...

[->o "Primary Object": <update>
"Primary Object" ->o "Inheritance A": PATCH

"Primary Object" ->o "Inheritance B": GET

 ... until location gets deleted ...

[->x "Primary Object": <delete>
"Primary Object" ->x "Inheritance A": PATCH
deactivate "Primary Object"
deactivate "Inheritance A"

"Primary Object" ->x "Inheritance B": GET
deactivate "Inheritance B"

@enduml
</code>
</pre>

---
