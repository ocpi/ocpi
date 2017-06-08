# _CDRs_ module

**Module Identifier: `cdrs`**

A **Charge Detail Record** is the description of a concluded charging
session. The CDR is the only billing-relevant object.
CDRs are sent from the CPO to the eMSP after the charging session has ended.
There is no requirement to send CDRs semi-realtime, it is seen as good practice to send them
ASAP. But if there is an agreement between parties to send them for example once a month, that is also allowed by OCPI.


## 1. Flow and Lifecycle

CDRs are created by the CPO. They probably only will be sent to the eMSP that will be paying the bill of a charging session. Because a CDR is for billing purposes, it cannot be changed/replaced, once sent to the eMSP, changes are not allowed in a CDR.
 

### 1.1 Push model

When the CPO creates CDR(s) they push them to the relevant eMSP by calling [POST](#222-post-method) on the eMSPs CDRs endpoint with the newly created CDR(s). A CPO is not required to send ALL CDRs to ALL eMSPs, it is allowed to only send CDRs to the eMSP that a CDR is relevant to.

CDRs should contain enough information (dimensions) to allow the eMSP to validate the total costs. 
It is advised to send enough information to the eMSP so it can calculate its own costs for billing their customer. An eMSP might have a very different contract/pricing model with the EV driver than the tariff structure from the CPO.

_NOTE: CDRs can not yet be updated or removed. This might be added in a future version of OCPI._

If the CPO, for any reason wants to view a CDR it has posted to a eMSP system, the CPO can retrieve the CDR by calling the [GET](#221-get-method) on the eMSPs CDRs endpoint at the URL returned in the response to the [POST](#222-post-method).


### 1.2 Pull model

eMSPs who do not support the push model need to call
[GET](#211-get-method) on the CPOs CDRs endpoint to receive a list of CDRs.

This [GET](#211-get-method) can also be used, combined with the Push model to retrieve CDRs, after the system (re)connects to a CPO, to get a list of CDRs, 'missed' during a time offline.

A CPO is not required to return all known CDRs, the CPO is allowed to return only the CDRs that are relevant for the requesting eMSP.

## 2. Interfaces and endpoints

There is both a CPO and an eMSP interface for CDRs. Depending on business requirements parties can decide to use
the CPO Interface/Get model, or the eMSP Interface/Push model, or both. 
Push is the preferred model to use, the eMSP will receive CDRs when created by the CPO.


### 2.1 CPO Interface

The CDRs endpoint can be used to create or retrieve CDRs.

Example endpoint structure: `/ocpi/cpo/2.0/cdrs/?date_from=xxx&date_to=yyy`

<div><!-- ---------------------------------------------------------------------------- --></div>

| Method                  | Description                                                                      |
|-------------------------|----------------------------------------------------------------------------------|
| [GET](#211-get-method)  | Fetch CDRs, last updated (which in the current version of OCPI can only be the creation date/time) between the {date_from} and {date_to} ([paginated](transport_and_format.md#get))    |
| POST                    | n/a                                                                              |
| PUT                     | n/a                                                                              |
| PATCH                   | n/a                                                                              |
| DELETE                  | n/a                                                                              |
<div><!-- ---------------------------------------------------------------------------- --></div>


<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

#### 2.1.1 __GET__ Method

Fetch CDRs from the CPO systems. 


##### Request Parameters

If additional parameters: {date_from} and/or {date_to} are provided, only CDRs with `last_updated` between the given date_from and date_to will be returned.

This request is [paginated](transport_and_format.md#get), it supports the [pagination](transport_and_format.md#paginated-request) related URL parameters.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter     | Datatype                             | Required    | Description                                                               |
|---------------|--------------------------------------|-------------|---------------------------------------------------------------------------|
| date_from     | [DateTime](types.md#12-datetime-type)| no          | Only return CDRs that have `last_updated` after this Date/Time.           |
| date_to       | [DateTime](types.md#12-datetime-type)| no          | Only return CDRs that have `last_updated` before this Date/Time.          |
| offset        | int                                  | no          | The offset of the first object returned. Default is 0.                    |
| limit         | int                                  | no          | Maximum number of objects to GET.                                         |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The endpoint returns a list of CDRs matching the given parameters in the GET request, the header will contain the [pagination](transport_and_format.md#paginated-response) related headers. 

Any older information that is not specified in the response is considered as no longer valid.
Each object must contain all required fields. Fields that are not specified may be considered as null values.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Datatype              | Card. | Description                                                         |
|-----------------------|-------|---------------------------------------------------------------------|
| [CDR](#31-cdr-object) | *     | List of CDRs.                                                       |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 2.2 eMSP Interface

The CDRs endpoint can be used to create, or get CDRs.

Example endpoint structure: `/ocpi/emsp/2.0/cdrs`

<div><!-- ---------------------------------------------------------------------------- --></div>

| Method                   | Description                                          |
| ------------------------ | ---------------------------------------------------- |
| [GET](#221-get-method)   | Retrieve an existing CDR                             |
| [POST](#222-post-method) | Send a new CDR.                                      |
| PUT                      | n/a (CDRs cannot be replaced)                        |
| PATCH                    | n/a (CDRs cannot be updated)                         |
| DELETE                   | n/a (CDRs cannot be removed)                         |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.1 GET Method

Fetch CDRs from the eMSP system. 


##### Response URL

To retrieve an existing URL from the eMSP system, the URL, returned in the response to a POST of a new CDR, has to be used.


##### Response Data

The endpoint returns the requested CDR, if it exists

<div><!-- ---------------------------------------------------------------------------- --></div>

| Datatype              | Card. | Description                                  |
|-----------------------|-------|----------------------------------------------|
| [CDR](#31-cdr-object) | 1     | Requested CDR object.                        |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.2 POST Method

Creates a new CDR.

The post method should contain the full, final CDR object.

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

##### Request Body

In the post request the new CDR object is sent.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Type                            | Card. | Description                             |
|---------------------------------|-------|-----------------------------------------|
| [CDR](#31-cdr-object)           | 1     | New CDR object.                         |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Headers

The response should contain the URL to the just created CDR object in the eMSP system.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter  | Datatype                    | Required | Description                               |
|------------|-----------------------------|----------|-------------------------------------------|
| Location   | [URL](types.md#16-url-type) | yes      | URL to the newly created CDR in the eMSP system, can be used by the CPO system to do a GET on of the same CDR |
<div><!-- ---------------------------------------------------------------------------- --></div>

Example: Location: /ocpi/emsp/2.0/cdrs/123456



## 3. Object description

### 3.1 _CDR_ Object

The *CDR* object describes the Charging Session and its costs. How these costs are build up etc. 

<div><!-- ---------------------------------------------------------------------------- --></div>

| Property                                     | Type                                                     | Card. | Description                                                                                                                    |
|----------------------------------------------|----------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------------------------------|
| id                                           | [CiString](types.md#12-cistring-type)(36)                | 1     | Uniquely identifies the CDR within the CPOs platform (and suboperator platforms).                                              |
| start_date_time                              | [DateTime](types.md#12-datetime-type)                    | 1     | Start timestamp of the charging session.                                                                                       |
| stop_date_time                               | [DateTime](types.md#12-datetime-type)                    | 1     | Stop timestamp of the charging session.                                                                                       |
| auth_id                                      | [string](types.md#15-string-type)(36)                    | 1     | Reference to a token, identified by the auth_id field of the [Token](mod_tokens.md#32-token-object).                           |
| auth_method                                  | [AuthMethod](#41-authmethod-enum)                        | 1     | Method used for authentication.                                                                                                |
| location                                     | [Location](mod_locations.md#31-location-object)          | 1     | Location where the charging session took place, including only the relevant [EVSE](mod_locations.md#32-evse-object) and [Connector](mod_locations.md#33-connector-object). |
| meter_id                                     | [string](types.md#15-string-type)(255)                   | ?     | Identification of the Meter inside the Charge Point.                                                                           |
| currency                                     | [string](types.md#15-string-type)(3)                     | 1     | Currency of the CDR in ISO 4217 Code.                                                                                          |
| tariffs                                      | [Tariff](mod_tariffs.md#31-tariff-object)                | *     | List of relevant tariff elements, see: [Tariffs](mod_tariffs.md#31-tariff-object). When relevant, a "Free of Charge" tariff should also be in this list, and point to a defined "Free of Charge" tariff. | 
| charging_periods                             | [ChargingPeriod](#44-chargingperiod-class)               | +     | List of charging periods that make up this charging session. A session consists of 1 or more periods, where each period has a different relevant Tariff. |
| total_cost                                   | [number](types.md#14-number-type)                        | 1     | Total cost (excluding VAT) of this transaction.                                                                                |
| total_energy                                 | [number](types.md#14-number-type)                        | 1     | Total energy charged, in kWh.                                        |
| total_time                                   | [number](types.md#14-number-type)                        | 1     | total duration of this session (including the duration of charging and not charging), in hours.                                        |
| total_parking_time                           | [number](types.md#14-number-type)                        | ?     | Total duration during this session that the EV is not being charged (no energy being transfered between EVSE and EV), in hours.                                            |
| remark                                       | [string](types.md#15-string-type)(255)                   | ?     | Optional remark, can be used to provide addition human readable information to the CDR, for example: reason why a transaction was stopped.|
| last_updated                                 | [DateTime](types.md#12-datetime-type)                    | 1     | Timestamp when this CDR was last updated (or created).                                                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

NOTE: The duration of charging (energy being transferred between EVSE and EV) during this session can be calculated via: `total_time` - `total_parking_time`. 

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

#### Example of a CDR

```json
{
	"id": "12345",
	"start_date_time": "2015-06-29T21:39:09Z",
	"stop_date_time": "2015-06-29T23:37:32Z",
	"auth_id": "DE8ACC12E46L89",
	"auth_method": "WHITELIST",
	"location": {
		"id": "LOC1",
		"type": "on_street",
		"name": "Gent Zuid",
		"address": "F.Rooseveltlaan 3A",
		"city": "Gent",
		"postal_code": "9000",
		"country": "BE",
		"coordinates": {
			"latitude": "3.72994",
			"longitude": "51.04759"
		},
		"evses": [{
			"uid": "3256",
			"evse_id": "BE-BEC-E041503003",
			"STATUS": "AVAILABLE",
			"connectors": [{
				"id": "1",
				"standard": "IEC_62196_T2",
				"format": "SOCKET",
				"power_type": "AC_1_PHASE",
				"voltage": 230,
				"amperage": 64,
				"tariff_id": "11",
				"last_updated": "2015-06-29T21:39:01Z"
			}],
			"last_updated": "2015-06-29T21:39:01Z"
		}],
		"last_updated": "2015-06-29T21:39:01Z"
	},
	"currency": "EUR",
	"tariffs": [{
		"id": "12",
		"currency": "EUR",
		"elements": [{
			"price_components": [{
				"type": "TIME",
				"price": "2.00",
				"step_size": 300
			}],
			"last_updated": "2015-02-02T14:15:01Z"
		}]
	}],
	"charging_periods": [{
		"start_date_time": "2015-06-29T21:39:09Z",
		"dimensions": [{
			"type": "TIME",
			"volume": 1.973
		}]
	}],
	"total_cost": 4.00,
	"total_energy": 15.342,
	"total_time": 1.973,
	"last_updated": "2015-06-29T22:01:13Z"
}
```


## 4. Data types

### 4.1 AuthMethod *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>

| Value                | Description                                                                             |
|----------------------|-----------------------------------------------------------------------------------------|
| AUTH_REQUEST         | Authentication request from the eMSP                                                    |
| WHITELIST            | Whitelist used to authenticate, no request done to the eMSP                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

### 4.2 CdrDimension *class*

<div><!-- ---------------------------------------------------------------------------- --></div>

| Property        | Type                                            | Card. | Description                                                                 |
|-----------------|-------------------------------------------------|-------|-----------------------------------------------------------------------------|
| type            | [CdrDimensionType](#43-cdrdimensiontype-enum)   | 1     | Type of cdr dimension                                                       |
| volume          | [number](types.md#14-number-type)               | 1     | Volume of the dimension consumed, measured according to the dimension type. |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 4.3 CdrDimensionType *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>

| Value        | Description                                                             |
|--------------|-------------------------------------------------------------------------|
| ENERGY       | defined in kWh, default step_size is 1 Wh                               |
| FLAT         | flat fee, no unit                                                       |
| MAX_CURRENT  | defined in A (Ampere), Maximum current reached during charging session. |
| MIN_CURRENT  | defined in A (Ampere), Minimum current used during charging session.    |
| PARKING_TIME | time not charging: defined in hours, default step_size is 1 second.     |
| TIME         | time charging: defined in hours, default step_size is 1 second.         |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 4.4 ChargingPeriod *class*

A charging period consists of a start timestamp and a list of possible values that influence this period, for example: Amount of energy charged this period, maximum current during this period etc.

<div><!-- -------------------------------------------------------------------------------- --></div>

| Property               | Type                                   | Card. | Description                                                                  |
|------------------------|----------------------------------------|-------|------------------------------------------------------------------------------|
| start_date_time        | [DateTime](types.md#12-datetime-type)  | 1     | Start timestamp of the charging period. This period ends when a next period starts, the last period ends when the session ends. |
| dimensions             | [CdrDimension](#42-cdrdimension-class) | +     | List of relevant values for this charging period.                                                                               |
<div><!-- -------------------------------------------------------------------------------- --></div>

