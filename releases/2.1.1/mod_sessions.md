# _Sessions_ module

**Module Identifier: `sessions`**

The Session object describes one charging session. 
The Session object is owned by the CPO back-end system, and can be GET from the CPO system, or pushed by the CPO to another system.


## 1. Flow and Lifecycle

### 1.1 Push model

When the CPO creates a Session object they push it to the eMSPs by calling [PUT](#222-put-method) on the eMSPs Sessions endpoint with the newly created Session object.

Any changes to a Session in the CPO system are sent to the eMSP system by calling [PATCH](#223-patch-method) on the eMSPs Sessions endpoint with the updated Session object.

Sessions cannot be deleted, final status of a session is: `COMPLETED`.

When the CPO is not sure about the state or existence of a Session object in the eMSPs system, the CPO can call the [GET](#221-get-method) to validate the Session object in the eMSP system.   

### 1.2 Pull model

eMSPs who do not support the push model need to call [GET](#211-get-method) on the CPOs Sessions endpoint to receive a list of Sessions.

This [GET](#211-get-method) can also be used, combined with the Push model to retrieve Sessions after the system (re)connects to a CPO, to get a list Sessions 'missed' during a time offline.

## 2. Interfaces and endpoints

### 2.1 CPO Interface

Example endpoint structure: `/ocpi/cpo/2.0/sessions/?date_from=xxx&date_to=yyy`

<div><!-- ---------------------------------------------------------------------------- --></div>

| Method                 | Description                                                                             |
| ---------------------- | --------------------------------------------------------------------------------------- |
| [GET](#211-get-method) | Fetch Session objects of charging sessions last updated between the {date_from} and {date_to} ([paginated](transport_and_format.md#get)) |
| POST                   | n/a                                                                                     |
| PUT                    | n/a                                                                                     |
| PATCH                  | n/a                                                                                     |
| DELETE                 | n/a                                                                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>

#### 2.1.1 __GET__ Method

Fetch Sessions from the CPO systems. 

##### Request Parameters

Only Sessions with `last_update` between the given {date_from} and {date_to} will be returned.

This request is [paginated](transport_and_format.md#get), so also supports the [pagination](transport_and_format.md#paginated-request) related URL parameters.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter  | Datatype                              | Required | Description                                                                   |
|------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| date_from  | [DateTime](types.md#12-datetime-type) | yes      | Only return Sessions that have `last_updated` after this Date/Time.           |
| date_to    | [DateTime](types.md#12-datetime-type) | no       | Only return Sessions that have `last_updated` before this Date/Time.          |
| offset     | int                                   | no       | The offset of the first object returned. Default is 0.                        |
| limit      | int                                   | no       | Maximum number of objects to GET.                                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

##### Response Data

The response contains a list of Session objects that match the given parameters in the request, the header will contain the [pagination](transport_and_format.md#paginated-response) related headers.  

Any older information that is not specified in the response is considered as no longer valid.
Each object must contain all required fields. Fields that are not specified may be considered as null values.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Datatype                      | Card. | Description                                                             |
|-------------------------------|-------|-------------------------------------------------------------------------|
| [Session](#31-session-object) | *     | List of Session objects that match the request parameters               |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 2.2 eMSP Interface

Sessions is a [client owned object](transport_and_format.md#client-owned-object-push), so the end-points need to contain the required extra fields: {[party_id](credentials.md#credentials-object)} and {[country_code](credentials.md#credentials-object)}.
Example endpoint structure: 
`/ocpi/emsp/2.0/sessions/{country_code}/{party_id}/{session_id}` 

<div><!-- ---------------------------------------------------------------------------- --></div>

| Method                       | Description                                                         |
|------------------------------|---------------------------------------------------------------------|
| [GET](#221-get-method)       | Get the Session object from the eMSP system by its id {session_id}. |
| POST                         | n/a                                                                 |
| [PUT](#222-put-method)       | Send a new/updated Session object                                   |
| [PATCH](#223-patch-method)   | Update the Session object of id {session_id}.                       |
| DELETE                       | n/a                                                                 |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.1 __GET__ Method

The CPO system might request the current version of a Session object from the eMSP system for, 
for example validation purposes, or the CPO system might have received a error on a PATCH.

##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter        | Datatype                              | Required | Description                                                                   |
|------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code     | [string](types.md#15-string-type)(2)  | yes      | Country code of the CPO requesting this GET to the eMSP system.               |
| party_id         | [string](types.md#15-string-type)(3)  | yes      | Party ID (Provider ID) of the CPO requesting this GET to the eMSP system.     |
| session_id       | [string](types.md#15-string-type)(36) | yes      | id of the Session object to get from the eMSP system.                         |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The response contains the request Session object, if available.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Datatype                      | Card. | Description                                                   |
|-------------------------------|-------|---------------------------------------------------------------|
| [Session](#31-session-object) | 1     | Session object requested.                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.2 __PUT__ Method

Inform the system about a new/updated session in the eMSP backoffice by PUTing a _Session_ object.

##### Request Body

The request contains the new or updated Session object.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Session](#31-session-object)   | 1     | new Session object.                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


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

##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter        | Datatype                              | Required | Description                                                                   |
|------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code     | [string](types.md#15-string-type)(2)  | yes      | Country code of the CPO requesting this PUT to the eMSP system.               |
| party_id         | [string](types.md#15-string-type)(3)  | yes      | Party ID (Provider ID) of the CPO requesting this PUT to the eMSP system.     |
| session_id       | [string](types.md#15-string-type)(36) | yes      | id of the new or updated Session object.                                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.3 __PATCH__ Method

Same as the [PUT](#222-put-method) method, but only the fields/objects that have to be updated have to be present, other fields/objects that are not specified are considered unchanged.

##### Example: update the total cost

```json
PATCH To URL: https://www.server.com/ocpi/cpo/2.0/sessions/NL/TNM/101

{
  	"total_cost": 0.60
}
```


## 3. Object description

### 3.1 _Session_ Object

<div><!-- ---------------------------------------------------------------------------- --></div>

| Property                          | Type                                                       | Card. | Description                                                                                                    |
|-----------------------------------|------------------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------|
| id                                | [string](types.md#15-string-type)(36)                      | 1     | The unique id that identifies the session in the CPO platform.                                                 |
| start_datetime                    | [DateTime](types.md#12-datetime-type)                      | 1     | The time when the session became active.                                                                       |
| end_datetime                      | [DateTime](types.md#12-datetime-type)                      | ?     | The time when the session is completed.                                                                        |
| kwh                               | [number](types.md#14-number-type)                          | 1     | How many kWh are charged.                                                                                      |
| auth_id                           | [string](types.md#15-string-type)(36)                      | 1     | Reference to a token, identified by the auth_id field of the [Token](mod_tokens.md#32-token-object).           |
| auth_method                       | [AuthMethod](mod_cdrs.md#41-authmethod-enum)               | 1     | Method used for authentication.                                                                                |
| location                          | [Location](mod_locations.md#31-location-object)            | 1     | The location where this session took place, including only the relevant EVSE and connector                |
| meter_id                          | [string](types.md#15-string-type)(255)                     | ?     | Optional identification of the kWh meter.                                                                      |
| currency                          | [string](types.md#15-string-type)(3)                       | 1     | ISO 4217 code of the currency used for this session.                                                           |
| charging_periods                  | [ChargingPeriod](mod_cdrs.md#44-chargingperiod-class)      | *     | An optional list of charging periods that can be used to calculate and verify the total cost.                  |
| total_cost                        | [number](types.md#14-number-type)                          | ?     | The total cost (excluding VAT) of the session in the specified currency. This is the price that the eMSP will have to pay to the CPO. A total_cost of 0.00 means free of charge. When omitted, no price information is given in the Session object, this does not have to mean it is free of charge. |
| status                            | [SessionStatus](#41-sessionstatus-enum)                    | 1     | The status of the session.                                                                                  |
| last_updated                      | [DateTime](types.md#12-datetime-type)                      | 1     | Timestamp when this Session was last updated (or created).                                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


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


#### Examples

#### Simple Session example of a just starting session

```json
{
	"id": "101",
	"start_datetime": "2015-06-29T22:39:09Z",
	"kwh": 0.00,
	"auth_id": "DE8ACC12E46L89",
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
				"last_updated": "2015-06-29T22:39:09Z"
			}],
			"last_updated": "2015-06-29T22:39:09Z"
		}],
		"last_updated": "2015-06-29T22:39:09Z"
	},
	"currency": "EUR",
	"total_cost": 2.50,
	"status": "PENDING",
	"last_updated": "2015-06-29T22:39:09Z"
}
```

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->


##### Simple Session example of a short finished session

```json
{
	"id": "101",
	"start_datetime": "2015-06-29T22:39:09Z",
	"end_datetime": "2015-06-29T23:50:16Z",
	"kwh": 41.00,
	"auth_id": "DE8ACC12E46L89",
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
                "last_updated": "2015-06-29T23:09:10Z"
			}],
            "last_updated": "2015-06-29T23:09:10Z"
		}],
        "last_updated": "2015-06-29T23:09:10Z"
	},
	"currency": "EUR",
	"charging_periods": [{
		"start_date_time": "2015-06-29T22:39:09Z",
		"dimensions": [{
			"type": "ENERGY",
			"volume": 120
		}, {
			"type": "MAX_CURRENT",
			"volume": 30
		}]
	}, {
		"start_date_time": "2015-06-29T22:40:54Z",
		"dimensions": [{
			"type": "energy",
			"volume": 41000
		}, {
			"type": "MIN_CURRENT",
			"volume": 34
		}]
	}, {
		"start_date_time": "2015-06-29T23:07:09Z",
		"dimensions": [{
			"type": "PARKING_TIME",
			"volume": 0.718
		}]
	}],
	"total_cost": 8.50,
	"status": "COMPLETED",
	"last_updated": "2015-06-29T23:09:10Z"
}
```

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->


## 4. Data types

*Describe all datatypes used in this object*

### 4.1 SessionStatus *enum*

Defines the state of a session.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Property  | Description                                                                |
|-----------|----------------------------------------------------------------------------|
| ACTIVE    | The session is accepted and active. Al pre-condition are met: Communication between EV and EVSE (for example: cable plugged in correctly), EV or Driver is authorized.  EV is being charged, or can be charged. Energy is, or is not, being transfered. |
| COMPLETED | The session is finished successfully. No more modifications will be made to this session.          	                             |
| INVALID   | The session is declared invalid and will not be billed.                    |
| PENDING   | The session is pending, it has not yet started. Not all pre-condition are met. This is the initial state. This session might never become an _active_ session. |
<div><!-- ---------------------------------------------------------------------------- --></div>
