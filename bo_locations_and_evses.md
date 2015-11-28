# _Locations and EVSEs_ module

**Module Identifier: locations**

The location and EVSE objects live in the operators backend system. They
describe the charging locations of that operator.



## 1. Inheritances

### 1.1 Service Provider Inheritors

Each service provider can hold one inheritance of the locations objects
their customers have access to. The inheritance gets created and updated
by either calling the [GET](#311-get-method) method on the operator
endpoint (pull mode) or by calling [PUT](#321-put-method) and
[PATCH](#322-patch-method) th the provider endpoint (push mode).

The inheritance might differ from the master object due to different
needs and capabilities of the provider. However, it should follow all
updates to the master object as good as possible.



## 2. Flow and Lifecycle

When the operator creates locations and EVSEs they push them to the
subscribed providers by calling [PUT](#321-put-method) on their
location endpoint. This creates an inheritance (A) of the newly created
object. Providers who do not support push mode need to call
[GET](#311-get-method) on the operator's location endpoint to receive
the new object. This creates also an inheritance (B).

Any changes to the master object in the operator's system are
forwarded to all inheritances (A) in all subscribed provider systems by
calling [PATCH](#322-patch-method) on their locations endpoint.
Providers who do not support push mode need to call
[GET](#311-get-method) on the operator's location endpoint to receive
the updates in the master object. This updates their inheritance (B).

When the operator deletes the master object, they must update all
inheritances (A) in the provider systems by setting the `status`
field to `INOPERATIVE`. This marks the inheritance (A) as
invalid. Providers who do not support push mode need to call
[GET](#311-get-method) on the operator's location endpoint and filter
for non-existant master objects. Each of their own valid inheritances
(B) which do not have a corresponding master object in a later
GET-request have to be marked as invalid by setting `status` to `INOPERATIVE`.

![Lifecycle][location-lifecycle]



## 3. Interfaces and endpoints

*Explain which interfaces are available and which party should implement
which one.*


### 3.1 Charging Platform Operator Interface

*Describe the interface in detail.*

Example endpoint structure: `/ocpi/cpo/2.0/locations`

##### Methods

| Method                 | Description                                          |
| ---------------------- | ---------------------------------------------------- |
| [GET](#311-get-method) | Fetch all available locations and EVSEs.             |
| POST                   | n/a                                                  |
| PUT                    | n/a                                                  |
| PATCH                  | n/a                                                  |
| DELETE                 | n/a                                                  |


##### Data

The endpoint returns an object of two seperate lists: one list of available locations and one list of available EVSEs.

| Property  | Type                            | Card. | Description                              |
|-----------|---------------------------------|-------|------------------------------------------|
| locations | [Location](#41-location-object) | *     | List of all locations with valid EVSEs.  |
| evses     | [EVSE](#42-evse-object)         | *     | List of all valid EVSEs.                 |



#### 3.1.1 __GET__ Method

Fetch information about all available locations and EVSEs at this CPO.

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

Example endpoint structure: `/ocpi/emsp/2.0/locations`

##### Methods

| Method                        | Description                                          |
| ----------------------------- | ---------------------------------------------------- |
| GET                           | n/a                                                  |
| POST                          | n/a                                                  |
| [PUT](#321-put-method)        | Push all available locations and EVSEs to the eMSP, similar to the GET request to the CPO platform but in the other direction. |
| [PATCH](#322-patch-method)    | Notify the eMSP of partial updates to locations and EVSEs (such as the status). |
| DELETE                        | n/a  _(use PATCH)_                                    |

##### Data

| Property  | Type                            | Card. | Description                    |
|-----------|---------------------------------|-------|--------------------------------|
| locations | [Location](#41-location-object) | *     | List of locations.             |
| evses     | [EVSE](#42-evse-object)         | *     | List of EVSEs.                 |


#### 3.2.1 __PUT__ Method

Fully synchronise the eMSP by pushing all available locations and EVSEs. This is the exact equivalent to a GET request initiated by the eMSP to the CPO endpoint.

Any location or EVSE that is not specified in the message is considered as no longer valid. Each object must contain all required fields. Fields that are not specified may be considered as null values or their default values if specified in the OCPI protocol.


#### 3.2.2 __PATCH__ Method

Update messages are similar to synchronization messages except that only the object id is required. Unlike the PUT method, only the locations and fields that are updated are specified and any fields or objects that are not specified in the update message are considered unchanged.

##### Example: a simple status update

This is the most common type of update message to notify eMSPs that an EVSE is now occupied.

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
		}
	]
}
```

##### Example: delete an EVSE

An EVSE can be deleted by updating its *status* property.

```json
{
	"evses": [
		{
			"id": "BE-BEC-E041503001",
			"status": "INOPERATIVE",
		}
	]
}
```

_Note: To inform that an EVSE is scheduled for removal, the
status_schedule field can be used._


## 4. Object description


### 4.1 Location Object

The *Location* object describes the location and its properties where a group of EVSEs that belong together are installed. Typically the *Location* object is the exact location of the group of EVSEs, but it can also be the entrance of a parking garage which contains these EVSEs. The exact way to reach each EVSE can then be further specified by its own properties.

A *Location* without valid *EVSE* objects can be considered as expired and should no longer be displayed.

| Property             | Type                                         | Card. | Description                                                      |
|----------------------|----------------------------------------------|-------|------------------------------------------------------------------|
| id                   | string(15)                                   | 1     | Uniquely identifies the location within the CPOs platform (and suboperator platforms). |
| type                 | [LocationType](#511-locationtype-enum)       | 1     | The general type of the charge point location.                   |
| name                 | [String](types.md#15-string-type)(255)       | ?     | Display name of the location.                                    |
| address              | [String](types.md#15-string-type)(45)        | 1     | Street/block name and house number if available.                 |
| city                 | [String](types.md#15-string-type)(45)        | 1     | City or town.                                                    |
| postal_code          | [String](types.md#15-string-type)(10)        | 1     | Postal code of the location.                                     |
| country              | [String](types.md#15-string-type)(3)         | 1     | ISO 3166-1 alpha-3 code for the country of this location.        |
| coordinates          | [GeoLocation](#57-geolocation-class)         | 1     | Coordinates of the location.                                     |
| directions           | [DisplayText](types.md#15-displaytext-class) | *     | Human-readable directions on how to reach the location.          |
| operator             | [BusinessDetails](#51-businessdetails-class) | ?     | Information of the operator. When not specified, the information retreived from the `api_info` endpoint should be used instead. |
| suboperator          | [BusinessDetails](#51-businessdetails-class) | ?     | Information of the suboperator if available.                     |
| opening_times        | [Hours](#58-hours-class)                     | *     | The times when the EVSEs at the location can be accessed for charging. |
| charging_when_closed | boolean                                      | ?     | Indicates if the EVSEs are still charging outside the opening hours of the location. E.g. when the parking garage closes its barriers over night, is it allowed to charge till the next morning?  Default: **true**     |
| images               | [Image](#59-image-class)                     | *     | Links to images related to the location such as photos or logos. |


### 4.2 EVSE Object

The *EVSE* object describes the part that controls the power supply to a single EV in a single session. It always belongs to a *Location* object. It will only contain directions to get from the location to the EVSE (i.e. *floor*, *physical_number* or *directions*). When these properties are insufficient to reach the EVSE from the *Location* point, then it typically indicates that this EVSE should be put in a different *Location* object (sometimes with the same address but with different coordinates/directions).

An *EVSE* object has a list of connectors which can not be used simultaneously: only one connector per EVSE may be used at a time. The list of connectors is seen as atomic. This implies that for any changes or updates to a single connector, the full list of all connectors will have to be specified. Any connector not on that list is considered as deleted.

| Property             | Type                                               | Card. | Description                                            |
|----------------------|----------------------------------------------------|-------|--------------------------------------------------------|
| id                   | [String](types.md#15-string-type)(48)              | 1     | Uniquely identifies the EVSE within the CPOs platform (and suboperator platforms). |
| location_id          | [String](types.md#15-string-type)(15)              | 1     | The id of the *Location* object that contains this EVSE. If the *Location* object does not exist, this EVSE may be discarded (and it should not have been sent in the first place).   |
| status               | [Status](#515-status-enum)                         | 1     | Indicates the current status of the EVSE.              |
| status_schedule      | [StatusSchedule](#516-statusschedule-class)        | *     | Indicates a planned status in the future of the EVSE.  |
| capabilities         | [Capability](#52-capability-enum)                  | *     | List of functionalities that the EVSE is capable of.   |
| connectors           | [Connector](#53-connector-class)                   | +     | List of available connectors on the EVSE.              |
| floor_level          | [String](types.md#15-string-type)(4)               | ?     | Level on which the charging station is located (in garage buildings) in the locally displayed numbering scheme. |
| coordinates          | [GeoLocation](#57-geolocation-class)               | ?     | Coordinates of the EVSE.                               |
| physical_number      | [String](types.md#15-string-type)(4)               | ?     | A number on the EVSE for visual identification.        |
| directions           | [DisplayText](types.md#15-displaytext-class)       | *     | Human-readable directions when more detailed information on how to reach the EVSE from the *Location* is required. |
| parking_restrictions | [ParkingRestriction](#512-parkingrestriction-enum) | *     | The restrictions that apply to the parking spot.       |
| images               | [Image](#59-image-class)                           | *     | Links to images related to the EVSE such as photos or logos. |

## 5. Data types

*Describe all datatypes used in this object*

### 5.1 BusinessDetails *class*

| Property         | Type                       | Card. | Description                        |
|------------------|----------------------------|-------|------------------------------------|
| name             | string(100)                | 1     | Name of the operator.              |
| website          | [URL](types.md#14_url_type)     | ?     | Link to the operator's website.    |
| logo             | [Image](#59-image-class)   | ?     | Image link to the operator's logo. |


### 5.2 Capability *enum*

The capabilities of an EVSE.

| Value                    | Description                          |
|--------------------------|--------------------------------------|
| RESERVABLE               | The EVSE can be reserved.            |
| CHARGING_PROFILE_CAPABLE | The EVSE supports charging profiles. |


### 5.3 Connector *class*

A connector is the socket or cable available for the EV to make use of. A single EVSE may provide multiple connectors but only one of them can be in use at the same time. A connector always belongs to an *EVSE* object.

| Property             | Type                                        | Card. | Description                                                             |
|----------------------|---------------------------------------------|-------|-------------------------------------------------------------------------|
| id                   | string(15)                                  | 1     | Identifier of the connector within the EVSE. Two connectors may have the same id as long as they do not belong to the same *EVSE* object. |
| standard             | [ConnectorType](#55-connectortype-enum)     | 1     | The standard of the installed connector.                                |
| format               | [ConnectorFormat](#54-connectorformat-enum) | 1     | The format (socket/cable) of the installed connector.                   |
| power_type           | [PowerType](#513-powertype-enum)            | 1     |                                                                         |
| voltage              | int                                         | 1     | Voltage of the connector (line to neutral for AC_3_PHASE), in volt [V]. |
| amperage             | int                                         | 1     | maximum amperage of the connector, in ampere [A].                       |
| tariff_id            | string(15)                                  | ?     | Identifier of the current charging tariff structure                     |
| tariff_alt_text      | string(512)                                 | ?     | Alternative tariff info text (without any markup, so no HTML or Markdown etc) |
| tariff_alt_url       | [URL](types.md#14_url_type)                 | ?     | Alternative URL to tariff info                                          |
| terms_and_conditions | [URL](types.md#14_url_type)                 | ?     | URL to the operator's terms and conditions.                             |


### 5.4 ConnectorFormat *enum*

The format of the connector, whether it is a socket or a plug.

| Value  | Description |
|--------|-------------|
| SOCKET | The connector is a socket; the EV user needs to bring a fitting plug. |
| CABLE  | The connector is a attached cable; the EV users car needs to have a fitting inlet. |


### 5.5 ConnectorType *enum*

The socket or plug standard of the charging point.

| Value | Description |
|-------|-------------|
| Chademo | The connector type is CHAdeMO, DC |
| IEC-62196-T1 | IEC 62196 Type 1 "SAE J1772" |
| IEC-62196-T1-COMBO | Combo Type 1 based, DC |
| IEC-62196-T2 | IEC 62196 Type 2 "Mennekes" |
| IEC-62196-T2-COMBO | Combo Type 2 based, DC |
| IEC-62196-T3A | IEC 62196 Type 3A |
| IEC-62196-T3C | IEC 62196 Type 3C "Scame" |
| DOMESTIC-A | Standard/Domestic household, type "A", NEMA 1-15, 2 pins |
| DOMESTIC-B | Standard/Domestic household, type "B", NEMA 5-15, 3 pins |
| DOMESTIC-C | Standard/Domestic household, type "C", CEE 7/17, 2 pins |
| DOMESTIC-D | Standard/Domestic household, type "D", 3 pin |
| DOMESTIC-E | Standard/Domestic household, type "E", CEE 7/5 3 pins |
| DOMESTIC-F | Standard/Domestic household, type "F", CEE 7/4, Schuko, 3 pins |
| DOMESTIC-G | Standard/Domestic household, type "G", BS 1363, Commonwealth, 3  |pins
| DOMESTIC-H | Standard/Domestic household, type "H", SI-32, 3 pins |
| DOMESTIC-I | Standard/Domestic household, type "I", AS 3112, 3 pins |
| DOMESTIC-J | Standard/Domestic household, type "J", SEV 1011, 3 pins |
| DOMESTIC-K | Standard/Domestic household, type "K", DS 60884-2-D1, 3 pins |
| DOMESTIC-L | Standard/Domestic household, type "L", CEI 23-16-VII, 3 pins |
| TESLA-R | Tesla Connector "Roadster"-type (round, 4 pin) |
| TESLA-S | Tesla Connector "Model-S"-type (oval, 5 pin) |
| IEC-60309-2-single-16 | IEC 60309-2 Industrial Connector single phase 16  Amperes (usually blue) |
| IEC-60309-2-three-16 | IEC 60309-2 Industrial Connector three phase 16  Amperes (usually red) |
| IEC-60309-2-three-32 | IEC 60309-2 Industrial Connector three phase 32  Amperes (usually red) |
| IEC-60309-2-three-64 | IEC 60309-2 Industrial Connector three phase 64  Amperes (usually red) |


### 5.6 ExceptionalPeriod *class*

Specifies one exceptional period for opening or access hours.

 Field Name   |  Field Type                           |  Card.  |  Description
--------------|---------------------------------------|---------|-------------
 period_begin | [DateTime](types.md#11_datetime_type) |  1      |  Begin of the exception.
 period_end   | [DateTime](types.md#11_datetime_type) |  1      |  End of the exception.


### 5.7 GeoLocation *class*

| Property         | Type                                | Card. | Description                        |
|------------------|-------------------------------------|-------|------------------------------------|
| latitude         | [Decimal](types.md#12_decimal_type) | 1     | Latitude in decimal format.        |
| longitude        | [Decimal](types.md#12_decimal_type) | 1     | Longitude in decimal format.       |


### 5.8 Hours *class*

Opening and access hours for the location.

 Field Name             |  Field Type                                       |  Card.  |  Description
------------------------|---------------------------------------------------|---------|-------------
 *Choice: one of two*   |                                                   |         |
  > regular_hours       |  [RegularHours](#514-regularhours-class)          |  *      |  Regular hours, weekday based. Should not be set for representing 24/7 as this is the most common case.
  > twentyfourseven     |  boolean                                          |  1      |  True to represent 24 hours per day and 7 days per week, except the given exceptions.
 exceptional_openings   |  [ExceptionalPeriod](#56-exceptionalperiod-class) |  *      |  Exceptions for specified calendar dates, time-range based. Periods the station is operating/accessible. Additional to regular hours. May overlap regular rules.
 exceptional_closings   |  [ExceptionalPeriod](#56-exceptionalperiod-class) |  *      |  Exceptions for specified calendar dates, time-range based. Periods the station is not operating/accessible. Overwriting regularHours and exceptionalOpenings. Should not overlap exceptionalOpenings.


### 5.9 Image *class*

This class references images related to a EVSE in terms of a file name or uri. According to the roaming connection between one EVSE Operator and one or more Navigation Service Providers the hosting or file exchange of image payload data has to be defined. The exchange of this content data is out of scope of OCHP. However, the recommended setup is a public available web server hosted and updated by the EVSE Operator. Per charge point a unlimited number of images of each type is allowed. Recommended are at least two images where one is a network or provider logo and the second is a station photo. If two images of the same type are defined they should be displayed additionally, not optionally.

Photo Dimensions: 
The recommended dimensions for all photos are minimum 800 pixels wide and 600 pixels height. Thumbnail representations for photos should always have the same orientation than the original with a size of 200 to 200 pixels.

Logo Dimensions: 
The recommended dimensions for logos are exactly 512 pixels wide and 512 pixels height. Thumbnail representations for logos should be exactly 128 pixels in with and height. If not squared, thumbnails should have the same orientation than the original.

| Field Name | Field Type                               | Card. | Description                           |
|------------|------------------------------------------|-------|---------------------------------------|
| url        | [URL](types.md#14_url_type)              | 1     | URL from where the image data can be fetched through a web browser. |
| thumbnail  | [URL](types.md#14_url_type)              | ?     | URL from where a thumbnail of the image can be fetched through a webbrowser. |
| category   | [ImageCategory](#510-imagecategory-enum) | 1     | Describes what the image is used for. |
| type       | string(4)                                | 1     | Image type like: gif, jpeg, png, svg  |
| width      | int(5)                                   | ?     | Width of the full scale image         |
| height     | int(5)                                   | ?     | Height of the full scale image        |


### 5.10 ImageCategory *enum*

The category of an image to obtain the correct usage in an user presentation. Has to be set accordingly to the image content in order to guaranty the right usage.

| Value          | Description                                                                                                                  |
|----------------|------------------------------------------------------------------------------------------------------------------------------|
| charger        | Photo of the physical device that contains one or more EVSEs.                                                                |
| entrance       | Location entrance photo. Should show the car entrance to the location from street side.                                      |
| location       | Location overview photo.                                                                                                     |
| network        |  logo of a associated roaming network to be displayed with the EVSE for example in lists, maps and detailed information view |
| operator       |  logo of the charge points operator, for example a municipal, to be displayed with the EVSEs detailed information view or in lists and maps, if no networkLogo is present |
| other          | Other                                                                                                                        |
| owner          |  logo of the charge points owner, for example a local store, to be displayed with the EVSEs detailed information view        |


### 5.11 LocationType *enum*

Reflects the general type of the charge points location. May be used
for user information.

 Value              |  Description
:-------------------|:-------------
 on_street          |  Parking in public space.
 parking_garage     |  Multistorey car park.
 underground_garage |  Multistorey car park, mainly underground.
 parking_lot        |  A cleared area that is intended for parking vehicles, i.e. at super markets, bars, etc.
 other              |  None of the given possibilities.
 unknown            |  Parking location type is not known by the operator (default).


### 5.12 ParkingRestriction *enum*

This value, if provided, represents the restriction to the parking spot
for different purposes.

 Value       |  Description
:------------|:-------------
 ev_only     |  Reserved parking spot for electric vehicles.
 plugged     |  Parking allowed only while plugged in (charging).
 disabled    |  Reserved parking spot for disabled people with valid ID.
 customers   |  Parking spot for customers/guests only, for example in case of a hotel or shop.
 motorcycles |  Parking spot only suitable for (electric) motorcycles or scooters.


### 5.13 PowerType *enum*

The format of the connector, whether it is a socket or a plug.

| Value      | Description     |
|------------|-----------------|
| AC_1_PHASE | AC mono phase.  |
| AC_3_PHASE | AC 3 phase.     |
| DC         | Direct Current. |

### 5.14 RegularHours *class*

Regular recurring operation or access hours

 Field Name   |  Field Type  |  Card.  |  Description
:-------------|:-------------|:--------|:------------
 weekday      |  int(1)      |  1      |  Number of day in the week, from Monday (1) till Sunday (7)
 period_begin |  string(5)   |  1      |  Begin of the regular period given in hours and minutes. Must be in 24h format with leading zeros. Example: "18:15". Hour/Minute separator: ":" Regex: $[$0-2$]$$[$0-9$]$:$[$0-5$]$$[$0-9$]$
 period_end   |  string(5)   |  1      |  End of the regular period, syntax as for period_begin. Must be later than period_begin.



#### 5.14.1 Example

Operating on weekdays from 8am till 8pm with one exceptional opening on
22/6/2014 and one exceptional closing the Monday after:

```json
  "operating_times": {
    "regular_hours": [
      {
        "weekday": 1,
        "period_begin": "08:00",
        "period_end": "20:00"
      },
      {
        "weekday": 2,
        "period_begin": "08:00",
        "period_end": "20:00"
      },
      {
        "weekday": 3,
        "period_begin": "08:00",
        "period_end": "20:00"
      },
      {
        "weekday": 4,
        "period_begin": "08:00",
        "period_end": "20:00"
      },
      {
        "weekday": 5,
        "period_begin": "08:00",
        "period_end": "20:00"
      }
    ],
    "exceptional_openings": [
      {
        "period_begin": "2014-06-21T09:00:00+02:00",
        "period_end": "2014-06-21T12:00:00+02:00"
      }
    ],
    "exceptional_closings": [
      {
        "period_begin": "2014-06-24T00:00:00+02:00",
        "period_end": "2014-06-25T00:00:00+02:00"
      }
    ]
  }
```

This represents the following schedule, where ~~stroked out~~ days are without operation hours, **bold** days are where exceptions apply and regular displayed days are where the regular schedule applies.


| Weekday   | Mo | Tu | We | Th | Fr | Sa     | Su     | Mo | Tu         | We | Th | Fr | Sa     | Su     |
|-----------|----|----|----|----|----|--------|--------|----|------------|----|----|----|--------|--------|
| Date      | 16 | 17 | 18 | 19 | 20 | **21** | ~~22~~ | 23 | **~~24~~** | 25 | 26 | 27 | ~~28~~ | ~~29~~ |
| Open from | 08 | 08 | 08 | 08 | 08 | 09     | -      | 08 | -          | 08 | 08 | 08 | -      | -      |
| Open till | 20 | 20 | 20 | 20 | 20 | 12     | -      | 20 | -          | 20 | 20 | 20 | -      | -      |


### 5.15 Status *enum*

The status of an EVSE.

| Value       | Description |
|-------------|-------------|
| AVAILABLE   | The EVSE is able to start a new charging session. |
| RESERVED    | The EVSE is reserved for a particular EV driver and is unavailable for other drivers. |
| CHARGING    | The EVSE is in use. |
| BLOCKED     | The EVSE not accessible because of a physical barrier, i.e. a car. |
| OUTOFORDER  | The EVSE is currently out of order. |
| INOPERATIVE | The EVSE is not yet active or it is no longer available (deleted). |


### 5.16 StatusSchedule *class*

This type is used to schedule status periods in the future. The eMSP can provide this information to the EV user for trip planning purpose. A period MAY have no end. Example: "This station will be running from tomorrow. Today it is still planned and under construction."

| Property         | Type                                  | Card. | Description                                            |
|------------------|---------------------------------------|-------|--------------------------------------------------------|
| period_begin     | [DateTime](types.md#11_datetime_type) | 1     | Begin of the scheduled period.                         |
| period_end       | [DateTime](types.md#11_datetime_type) | ?     | End of the scheduled period, if known.                 |
| status           | [Status](#515-status-enum)            | 1     | Status value during the scheduled period.              |

Note that the scheduled status is purely informational. When the status actually changes, the CPO must push an update to the EVSEs `status` field itself.


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
