# _Sessions_ module

**Module Identifier: `sessions`**

The Session object describes one charging session. 
The Session object is owned by the CPO back-end system, and can be GET from the CPO system, 
or push by the CPO to another system.


## 1. Flow and Lifecycle

### 1.1 Push model

When the CPO creates a Session object they push it to the eMSPs by calling [PUT](#222-put-method) on the eMSPs
Sessions endpoint with the newly created Session object

Any changes to a Session in the CPO system are send to the eMSP system by calling [PATCH](#223-patch-method)
on the eMSPs Sessions endpoint with the updated Session object

When the CPO deletes a Session, they will update the eMSPs systems by calling [DELETE](#224-delete-method)
on the eMSPs Sessions endpoint, on the Sessions unique URL.

When the CPO is not sure about the state or existence of a Session object in the eMSPs system the 
CPO can call the [GET](#221-get-method) to validate the Session object in the eMSP system.   

### 1.2 Pull model

eMSPs who do not support the push model need to call
[GET](#211-get-method) on the CPOs Sessions endpoint to receive a list of Sessions.


## 2. Interfaces and endpoints

### 2.1 CPO Interface

Example endpoint structure: `/ocpi/cpo/2.0/sessions/?date_from=xxx&date_to=yyy`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                 | Description                                                                             |
| ---------------------- | --------------------------------------------------------------------------------------- |
| [GET](#211-get-method) | Fetch Session object of charging sessions started between the {date_from} and {date_to} ([paginated](transport_and_format.md#get)) |
| POST                   | n/a                                                                                     |
| PUT                    | n/a                                                                                     |
| PATCH                  | n/a                                                                                     |
| DELETE                 | n/a                                                                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>

#### 2.1.1 __GET__ Method

Fetch Sessions from the CPO systems. Only Sessions with a start date/time between the given {date_from} and {date_to} will be returned.

This request is [paginated](transport_and_format.md#get), so also supports the [pagination](transport_and_format.md#paginated-request) related URL parameters.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter  | Datatype                              | Required | Description                                                                   |
|------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| date_from  | [DateTime](types.md#12_datetime_type) | yes      | Begin charging session start Date/Time of the Sessions to fetch.              |
| date_to    | [DateTime](types.md#12_datetime_type) | no       | End charging session start Date/Time of the Sessons to fetch, if omitted all Sessions up to now are request to be returned. |
| offset     | int                                   | no       | The offset of the first object returned. Default is 0.                        |
| limit      | int                                   | no       | Maximum number of objects to GET.                                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

_NOTE: The CPO is allowed to return a (not specified) maximum amount of Sessions, to prevent overloading there system. In this version of OCPI it is not possible to detect if the CPO returned not all Sessions that match the filter._  

##### Response Data

The response contains a list of Session objects that match the given parameters in the request, the header will contain the [pagination](transport_and_format.md#paginated-response) related headers.  

Any older information that is not specified in the response is considered as no longer valid.
Each object must contain all required fields. Fields that are not specified may be considered as null values.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter | Datatype                      | Card. | Description                                                             |
|-----------|-------------------------------|-------|-------------------------------------------------------------------------|
| Sessions  | [Session](#31-session-object) | *     | List of Session objects that match the request parameters               |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 2.2 eMSP Interface

Example endpoint structure: `/ocpi/emsp/2.0/sessions/` and
`/ocpi/emsp/2.0/sessions/{session-id}/`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                       | Description                                                         |
|------------------------------|---------------------------------------------------------------------|
| [GET](#221-get-method)       | Get the Session object from the eMSP system by its id {session-id}. |
| POST                         | n/a                                                                 |
| [PUT](#222-put-method)       | Send a new/updated Session object                                   |
| [PATCH](#223-patch-method)   | Update the Session object of id {session-id}.                       |
| [DELETE](#224-delete-method) | Delete the Session object of id {session-id}.                       |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.1 __GET__ Method

The CPO system might request the current version of a Session object from the eMSP system for, 
for example validation purposes, or the CPO system might have received a error on a PATCH.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter    | Datatype                              | Required | Description                                                                   |
|--------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| {session-id} | [string](types.md#16-string-type)(15) | yes      | id of the Session object to get from the eMSP system                          |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The response contains the request Session object, if available.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Datatype                      | Card. | Description                                                   |
|-------------------------------|-------|---------------------------------------------------------------|
| [Session](#31-session-object) | ?     | Session object requested.                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.2 __PUT__ Method

Inform the system about a new/updated session in the eMSP backoffice by PUTing a _Session_ object.

##### Data

The request contains the new Session Object.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Session](#31-session-object)   | 1     | new Session object.                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.3 __PATCH__ Method

Inform about updates in the _Session_ object.

##### Parameters

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter  | Datatype                              | Required | Description                               |
|------------|---------------------------------------|----------|-------------------------------------------|
| session-id | [string](types.md#16-string-type)(15) | yes      | ID of the Session to be updated           |
<div><!-- ---------------------------------------------------------------------------- --></div>

##### Data

The request contains the Session Object to be updated.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Session](#31-session-object)   | 1     | new Session object.                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.4 __DELETE__ Method

Inform about a deleted _Session_ object.

##### Parameters

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter  | Datatype                              | Required | Description                               |
|------------|---------------------------------------|----------|-------------------------------------------|
| session-id | [string](types.md#16-string-type)(15) | yes      | ID of the Session to be deleted           |
<div><!-- ---------------------------------------------------------------------------- --></div>


## 3. Object description

### 3.1 _Session_ Object

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property                       | Type                                                       | Card. | Description                                                                                                    |
|--------------------------------|------------------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------|
| id                             | [string](types.md#16-string-type)(15)                      | 1     | The unique id that identifies the session in the CPO platform.                                                 |
| start_datetime                 | [DateTime](types.md#12_datetime_type)                      | 1     | The time when the session became active.                                                                       |
| end_datetime                   | [DateTime](types.md#12_datetime_type)                      | ?     | The time when the session is completed.                                                                        |
| kwh                            | [decimal](types.md#13_decimal_type)                        | 1     | How many kWh are charged.                                                                                      |
| auth_id                        | [string](types.md#16-string-type)(15)                      | 1     | An id provided by the authentication used, so that the eMSP knows to which driver the session belongs.         |
| auth_method                    | [AuthMethod](mod_cdrs.md#41-authmethod-enum)               | 1     | Method used for authentication.                                                                                |
| location                       | [Location](mod_locations.md#31-location-object)            | 1     | The location where this session took place, including only the relevant EVSE and connector                |
| meter_id                       | [string](types.md#16-string-type)(255)                     | ?     | Optional identification of the kWh meter.                                                                      |
| currency                       | [string](types.md#16-string-type)(3)                       | 1     | ISO 4217 code of the currency used for this session.                                                           |
| charging_periods               | [ChargingPeriod](mod_cdrs.md#43-chargingperiod-class)      | *     | An optional list of charging periods that can be used to calculate and verify the total cost.                  |
| total_cost                     | [decimal](types.md#13_decimal_type)                        | 1     | The total cost (excluding VAT) of the session in the specified currency. This is the price that the eMSP will have to pay to the CPO. |
| status                         | [SessionStatus](#41-sessionstatus-enum)                    | 1     | The status of the session.                                                                                  |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### Examples

#### Simple Session example of a just starting session

```json
{
	"id": "101",
	"start_datetime": "2015-06-29T22:39:09+02:00",
	"kwh": "0.00",
	"auth_id": "FA54320",
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
		"evse": {
			"uid": "3256",
			"evse_id": "BE-BEC-E041503003",
			"STATUS": "AVAILABLE",
			"connectors": [{
				"id": "1",
				"standard": "IEC-62196-T2",
				"format": "SOCKET",
				"power_type": "AC_1_PHASE",
				"voltage": "230",
				"amperage": "64",
				"tariff_id": "11"
			}]
		}
	},
	"currency": "EUR",
	"total_cost": "2.50",
	"status": "PENDING"
}
```

##### Simple Session example of a short finished session

```json
{
	"id": "101",
	"start_datetime": "2015-06-29T22:39:09+02:00",
	"end_datetime": "2015-06-29T23:50:16+02:00",
	"kwh": "0.00",
	"auth_id": "FA54320",
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
		"evse": {
			"uid": "3256",
			"evse_id": "BE-BEC-E041503003",
			"STATUS": "AVAILABLE",
			"connectors": [{
				"id": "1",
				"standard": "IEC-62196-T2",
				"format": "SOCKET",
				"power_type": "AC_1_PHASE",
				"voltage": "230",
				"amperage": "64",
				"tariff_id": "11"
			}]
		}
	},
	"connector_id": "1",
	"currency": "EUR",
	"charging_periods": [{
		"start_date_time": "2015-06-29T22:39:09+02:00",
		"dimensions": [{
			"type": "energy",
			"volume": "120"
		}, {
			"type": "max_current",
			"volume": "30"
		}]
	}, {
		"start_date_time": "2015-06-29T22:40:54+02:00",
		"dimensions": [{
			"type": "energy",
			"volume": "41000"
		}, {
			"type": "min_current",
			"volume": "34"
		}]
	}, {
		"start_date_time": "2015-06-29T23:07:09+02:00",
		"dimensions": [{
			"type": "parking_time",
			"volume": "2585"
		}]
	}],
	"total_cost": "8.50",
	"status": "COMPLETED"
}
```


## 4. Data types

*Describe all datatypes used in this object*

### 4.1 SessionStatus *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property  | Description                                                                |
|-----------|----------------------------------------------------------------------------|
| ACTIVE    | The session is accepted and active.                                        |
| COMPLETED | The session has finished succesfully.                                      |
| INVALID   | The session is declared invalid and will not be billed.                    |
| PENDING   | The session is pending and has not yet started. This is the initial state. |
<div><!-- ---------------------------------------------------------------------------- --></div>

