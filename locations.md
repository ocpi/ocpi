## Charging locations endpoint

Identifier: `locations`

### Charging Platform Operator

Example: `/ocpi/cpo/2.0/locations`

| Method   | Description                               |
| -------- | ----------------------------------------- |
| GET      | Fetch all available locations and EVSE's. |

#### Data

| Property  | Type        | Card. | Description                              |
|-----------|-------------|-------|------------------------------------------|
| locations | Location    | +     | List of all locations with valid EVSE's. |
| evses     | EVSE        | +     | List of all valid EVSE's.                |


#### Requests

##### GET

Fetch information about all available locations and EVSE's at this CPO.

Any older information that is not specified in the message is considered as no longer valid.

Each object must contain all required fields. Fields that are not specified may be considered as null values.

#### Example

```json
{
  "locations": [
    {
      "location_id": "LOC1",
      "operator_id": "BC",
      "operator_name": "BeCharged",
      "latitude": 51.04759,
      "longitude": 3.72994,
      "address": "F.Rooseveltlaan 3A",
      "postcode": "9000",
      "city": "Gent",
      "country": "BE",
      "name": "Gent Zuid"
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
          "price_schemes": [
            {
              "default": 1,
              "expiry_date": "2020-12-31T23:59Z",
              "start_date": "2010-01-01T00:00Z",
              "tariff": [
                {
                  "currency": "EUR",
                  "price_gross": 0.1936,
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
              "expiry_date": "2020-12-31T23:59Z",
              "start_date": "2010-01-01T00:00Z",
              "tariff": [
                {
                  "currency": "eur",
                  "price_gross": 0.1936,
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
          "price_schemes": [
            {
              "default": 1,
              "expiry_date": "2020-12-31T23:59Z",
              "start_date": "2010-01-01T00:00Z",
              "tariff": [
                {
                  "currency": "EUR",
                  "price_gross": 0.1936,
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
      "floor": -1,
      "valid_from": "2015-04-27T10:00:00+0200"
    },
    {
      "evse_id": "BE-BEC-E041503002",
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
          "price_schemes": [
            {
              "default": 1,
              "expiry_date": "2020-12-31T23:59Z",
              "start_date": "2010-01-01T00:00Z",
              "tariff": [
                {
                  "currency": "EUR",
                  "price_gross": 0.1936,
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
      "floor": -2
    }
  ]
}
```


## Mobility Service Provider

Example: `/ocpi/emsp/2.0/locations`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| PUT      | Push all available locations and EVSE's to the eMSP, similar to the GET request to the CPO platform but in the other direction. |
| PATCH    | Notify the eMSP of partial updates to locations and EVSE's (such as the status). |


#### Data

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
| locations | Location    | *     | List of locations.             |
| evses     | EVSE        | *     | List of EVSE's.                |


#### Requests

##### PUT

Fully synchronise the eMSP by pushing all available locations and EVSE's. This is the exact equivalent to a GET request initiated by the eMSP to the CPO endpoint.

Any location or EVSE that is not specified in the message is considered as no longer valid. Each object must contain all required fields. Fields that are not specified may be considered as null values or their default values if specified in the OCPI protocol.

##### PATCH

Update messages are similar to synchronisation messages except that only the object id is required. Unlike the PUT method, only the locations and fields that are updated are specified and any fields or objects that are not specified in the update message are considered unchanged.

###### Example: a simple status update

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


###### Example: advanced update

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

###### Example: add an EVSE

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

###### Example: delete an EVSE

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

