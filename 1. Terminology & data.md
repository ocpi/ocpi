## Terminology and Data

 * **OCPI** Open Charge Point Interface
 * **NDR** Notification Detail Record
 * **CDR** Charge Detail Record
 * **CPO** Charging Point Operator
 * **eMSP** e-Mobility Service Provider


### Charging topology

The charging topology, as relevant to the eMSP, consists of three entities:

* *Connector* is a specific socket or cable available for the EV to make use of.
* *EVSE* is the part that controls the power supply to a single EV in a single session. An EVSE may provide multiple connectors but only one of these can be active at the same time.
* *Location* is a group of one or more EVSE's that belong together geographically or spatially.

![Topology](data/topology.png)

A Location is typically the exact location of one or more EVSE's, but it can also be the entrance of a parking garage or a gated community. It is up to the CPO to use whatever makes the most sense in a specific situation. Once arrived at the location, any further instructions to reach the EVSE from the Location are stored in the EVSE object itself (such as the floor number, visual identification or manual instructions).


### Variable names

In order to prevent issues with Capitals in variable names, the naming in JSON is not CamelCase but camel_case. All variables are lowercase and include an underscore for a space.


### Data types

When defining the cardinality of a field, the following symbols are used during the document:

| Symbol | Description                     | Type     |
|--------|---------------------------------|----------|
| ?      | An optional object.             | Object   |
| 1      | Required object.                | Object   |
| *      | A list of zero or more objects. | [Object] |
| +      | A list of at least one object.  | [Object] |


#### Decimals

Decimals are formatted as numbers in JSON. They should be interpreted as decimals and not floating points.

Example:

    0.68
    3.1415

#### DateTime

All timestamps are formatted as string(25) using the combined date and time format from the ISO 8601 standard. The absence of the timezone designator implies a UTC timestamp.


Example:

    2015-06-29T22:39:09+02:00
    2015-06-29T20:39:09Z
    2015-06-29T20:39:09

#### URL's

An URL a string(255) type following the [w3.org spec](http://www.w3.org/Addressing/URL/uri-spec.html).

#### Image *class*

This class references images related to a EVSE in terms of a file name or uri. According to the roaming connection between one EVSE Operator and one or more Navigation Service Providers the hosting or file exchange of image payload data has to be defined. The exchange of this content data is out of scope of OCHP. However, the recommended setup is a public available web server hosted and updated by the EVSE Operator. Per charge point a unlimited number of images of each type is allowed. Recommended are at least two images where one is a network or provider logo and the second is a station photo. If two images of the same type are defined they should be displayed additionally, not optionally.

##### Photo Dimensions

The recommended dimensions for all photos are minimum 800 pixels wide and 600 pixels height. Thumbnail representations for photos should always have the same orientation than the original with a size of 200 to 200 pixels.

##### Logo Dimensions

The recommended dimensions for logos are exactly 512 pixels wide and 512 pixels height. Thumbnail representations for logos should be exactly 128 pixels in with and height. If not squared, thumbnails should have the same orientation than the original.

| Field Name | Field Type    | Card. | Description                           |
|------------|---------------|-------|---------------------------------------|
| url        | string(255)   | 1     | URL from where the image data can be fetched through a web browser. |
| thumbnail  | string(255)   | ?     | URL from where a thumbnail of the image can be fetched through a webbrowser. |
| category   | ImageCategory | 1     | Describes what the image is used for. |
| type       | string(4)     | 1     | Image type like: gif, jpeg, png, svg  |
| width      | int(5)        | ?     | Width of the full scale image         |
| height     | int(5)        | ?     | Height of the full scale image        |

#### ImageCategory *enum*

The category of an image to obtain the correct usage in an user presentation. Has to be set accordingly to the image content in order to guaranty the right usage.

| Value          | Description |
|----------------|-------------|
| charger        | Photo of the physical device that contains one or more EVSE's. |
| location       | Location overview photo. |
| entrance       | Location entrance photo. Should show the car entrance to the location from street side. |
| other          | Other |


#### GeoLocation *class*

| Property         | Type         | Card. | Description                        |
|------------------|--------------|-------|------------------------------------|
| latitude         | string(10)   | 1     | Latitude in decimal format.        |
| longitude        | string(11)   | 1     | Longitude in decimal format.       |

#### Operator *class*

| Property         | Type         | Card. | Description                        |
|------------------|--------------|-------|------------------------------------|
| name             | string(100)  | 1     | Name of the operator.              |
| website          | URL          | ?     | Link to the operator's website.    |
| logo             | Image        | ?     | Image link to the operator's logo. |


#### Hours *class*

Opening and access hours for the location.

 Field Name             |  Field Type             |  Card.  |  Description
:-----------------------|:------------------------|:--------|:------------
 *Choice: one of two*   |                         |         |
  > regular_hours       |  RegularHours           |  *      |  Regular hours, weekday based. Should not be set for representing 24/7 as this is the most common case.
  > twentyfourseven     |  boolean                |  1      |  True to represent 24 hours per day and 7 days per week, except the given exceptions.
 exceptional_openings   |  ExceptionalPeriod      |  *      |  Exceptions for specified calendar dates, time-range based. Periods the station is operating/accessible. Additional to regular hours. May overlap regular rules.
 exceptional_closings   |  ExceptionalPeriod      |  *      |  Exceptions for specified calendar dates, time-range based. Periods the station is not operating/accessible. Overwriting regularHours and exceptionalOpenings. Should not overlap exceptionalOpenings.


##### RegularHours *class*

Regular recurring operation or access hours

 Field Name   |  Field Type  |  Card.  |  Description
:-------------|:-------------|:--------|:------------
 weekday      |  int(1)      |  1      |  Number of day in the week, from Monday (1) till Sunday (7)
 period_begin |  string(5)   |  1      |  Begin of the regular period given in hours and minutes. Must be in 24h format with leading zeros. Example: "18:15". Hour/Minute separator: ":" Regex: $[$0-2$]$$[$0-9$]$:$[$0-5$]$$[$0-9$]$
 period_end   |  string(5)   |  1      |  End of the regular period, syntax as for period_begin. Must be later than period_begin.

##### ExceptionalPeriod *class*

Specifies one exceptional period for opening or access hours.

 Field Name   |  Field Type  |  Card.  |  Description
:-------------|:-------------|:--------|:------------
 period_begin |  DateTime    |  1      |  Begin of the exception.
 period_end   |  DateTime    |  1      |  End of the exception.

##### Example

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


#### Connector *class*

A connector is the socket or cable available for the EV to make use of. A single EVSE may provide multiple connectors but only one of them can be in use at the same time. A connector always belongs to an *EVSE* object.

| Property         | Type            | Card. | Description                                            |
|------------------|-----------------|-------|--------------------------------------------------------|
| id               | string(15)      | 1     | Identifier of the connector within the EVSE. Two connectors may have the same id as long as they do not belong to the same *EVSE* object. |
| standard         | ConnectorType   | 1     | The standard of the installed connector.               |
| format           | ConnectorFormat | 1     | The format (socket/cable) of the installed connector.  |
| power_type       | PowerType       | 1     |  |
| voltage          | int             | 1     | Voltage of the connector (line to neutral for AC_3_PHASE), in volt [V]. |
| amperage         | int             | 1     | maximum amperage of the connector, in ampere [A]. |
| price_schemes    | PricingScheme   | *     | List of applicable price schemes (see *PriceScheme* specification in OCPP2.0). |
| terms_and_conditions | URL         | ?     | URL to the operator's terms and conditions. |


##### ConnectorType *enum*

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


##### ConnectorFormat *enum*

The format of the connector, whether it is a socket or a plug.

| Value  | Description |
|--------|-------------|
| SOCKET | The connector is a socket; the EV user needs to bring a fitting plug. |
| CABLE  | The connector is a attached cable; the EV users car needs to have a fitting inlet. |

##### PowerType *enum*

The format of the connector, whether it is a socket or a plug.

| Value      | Description     |
|------------|-----------------|
| AC_1_PHASE | AC mono phase.  |
| AC_3_PHASE | AC 3 phase.     |
| DC         | Direct Current. |


#### Status *enum*

The status of an EVSE.

| Value       | Description |
|-------------|-------------|
| AVAILABLE   | The EVSE is able to start a new charging session. |
| RESERVED    | The EVSE is reserved for a particular EV driver and is unavailable for other drivers. |
| CHARGING    | The EVSE is in use. |
| BLOCKED     | The EVSE not accessible because of a physical barrier, i.e. a car. |
| OUTOFORDER  | The EVSE is currently out of order. |
| INOPERATIVE | The EVSE is not yet active or it is no longer available (deleted). |


#### StatusSchedule *class*

This type is used to schedule status periods in the future. The eMSP can provide this information to the EV user for trip planning purpose. A period MAY have no end. Example: "This station will be running from tomorrow. Today it is still planned and under construction."

| Property         | Type            | Card. | Description                                            |
|------------------|-----------------|-------|--------------------------------------------------------|
| period_begin     | DateTime        | 1     | Begin of the scheduled period.                         |
| period_end       | DateTime        | ?     | End of the scheduled period, if known.                 |
| status           | Status          | 1     | Status value during the scheduled period.              |

Note that the scheduled status is purely informational. When the status actually changes, the CPO must push an update to the EVSE's `status` field itself.


#### Capability *enum*

The capabilities of an EVSE.

| Value             | Description                          |
|-------------------|--------------------------------------|
| RESERVABLE        | The EVSE can be reserved.            |
| CHARGING_PROFILES | The EVSE supports charging profiles. |


### Data objects

#### Location objects

The *Location* object describes the location and its properties where a group of EVSE's that belong together are installed. Typically the *Location* object is the exact location of the group of EVSE's, but it can also be the entrance of a parking garage which contains these EVSE's. The exact way to reach each EVSE can then be further specified by its own properties.

A *Location* without valid *EVSE* objects can be considered as expired and should no longer be displayed.

| Property         | Type         | Card. | Description                                            |
|------------------|--------------|-------|--------------------------------------------------------|
| id               | string(15)   | 1     | Uniquely identifies the location within the CPO's platform (and suboperator platforms). |
| name             | string(255)  | ?     | Display name of the location.                          |
| address          | string(45)   | 1     | Street/block name and house number if available.       |
| city             | string(45)   | 1     | City or town.                                          |
| postal_code         | string(10)   | 1     | Postal code of the location.                        |
| country          | string(3)    | 1     | ISO 3166-1 alpha-3 code for the country of this location. |
| coordinates      | GeoLocation  | 1     | Coordinates of the location.                           |
| directions       | string(255)  | ?     | Human-readable directions on how to reach the location. |
| operator         | Operator     | ?     | Information of the operator. When not specified, the information retreived from the `api_info` endpoint should be used instead. |
| suboperator      | Operator     | ?     | Information of the suboperator if available.           |
| operating_times  | Hours        | *     | The times when the EVSE's at the location can be used for charging. |
| images           | Image        | *     | Links to images related to the location such as photos or logos. |


#### EVSE objects

The *EVSE* object describes the part that controls the power supply to a single EV in a single session. It always belongs to a *Location* object. It will only contain directions to get from the location to the EVSE (i.e. *floor*, *physical_number* or *directions*). When these properties are insufficient to reach the EVSE from the *Location* point, then it typically indicates that this EVSE should be put in a different *Location* object (sometimes with the same address but with different coordinates/directions).

An *EVSE* object has a list of connectors which can not be used simultaneously: only one connector per EVSE may be used at a time. The list of connectors is seen as atomic. This implies that for any changes or updates to a single connector, the full list of all connectors will have to be specified. Any connector not on that list is considered as deleted.

| Property         | Type           | Card. | Description                                            |
|------------------|----------------|-------|--------------------------------------------------------|
| id               | string(48)     | 1     | Uniquely identifies the EVSE within the CPO's platform (and suboperator platforms). |
| location_id      | string(15)     | 1     | The id of the *Location* object that contains this EVSE. If the *Location* object does not exist, this EVSE may be discarded (and it should not have been sent in the first place). |
| status           | Status         | 1     | Indicates the current status of the EVSE.            |
| status_schedule  | StatusSchedule | 1     | Indicates the current status of the EVSE.            |
| capabilities     | Capability     | *     | List of functionalities that the EVSE is capable of. |
| connectors       | Connector      | +     | List of available connectors on the EVSE.            |
| floor_level      | string(4)      | ?     | Level on which the charging station is located (in garage buildings) in the locally displayed numbering scheme. |
| coordinates      | GeoLocation    | ?     | Coordinates of the EVSE.                             |
| physical_number  | int            | ?     | A number on the EVSE for visual identification.      |
| directions       | string(255)    | ?     | Human-readable directions when more detailed information on how to reach the EVSE from the *Location* is required. |
| images           | Image          | *     | Links to images related to the EVSE such as photos or logos. |

