# Sessions and CDRs

This section details the API calls used to transmit dynamic session updates and full charge detail records (CDRs).

A CDR is regarded as a finalized, immutable instance of a session object.
The [Session](#session) data type defined below is thus used for modelling both, session objects and CDRs.

There are two separate ways of creating a CDR at the provider backoffice:

1. Creating a session, then creating a CDR from it; this is detailed in the next three endpoints
2. Creating a CDR directly; see [POSTing to the cdrs endpoint](#cdr-creation-endpoint)

## Mobility Service Provider

### Sessions endpoint

Identifier: `sessions`

Example: `/ocpi/msp/2.0/sessions`

This endpoint is used by a CPO to register a new session at the eMSP backoffice. Upon successful session registration,
the eMSP returns further endpoints to the CPO where the status of the session object can be updated according to the state of the session,
e.g. the amount of kWh can be increased, a new charging period started, etc.


#### Data

##### Session
| Property          | Type              | Card. | Description                                                    |
|-------------------|-------------------|-------|----------------------------------------------------------------|
| id                | string            | 1     | The unique id that identifies the session in the CPO platform. |
| start_datetime    | DateTime          | 1     | The time when the session became active.     |
| end_datetime      | DateTime          | ?     | The time when the session is completed.      |
| kwh               | Decimal           | 1     | How many kWh are charged.                    |
| auth_id           | string            | 1     | An id provided by the authentication mechanism so that the eMSP knows to which driver the session belongs. |
| location          | [Location](https://github.com/ocpi/ocpi/blob/master/terminology.md#location-class)      | 1     | The location where this session took place. |
| evse              | [EVSE](https://github.com/ocpi/ocpi/blob/master/terminology.md#evse-class)              | 1     | The EVSE that was used for this session. |
| connector_number  | int               | 1     | Zero-based index of the connector used at the EVSE.  |
| meter_id          | string            | ?     | Optional identification of the kWh meter.            |
| currency          | string            | 1     | ISO 4217 code of the currency used for this session. |
| charging_periods  | [ChargingPeriod](#chargingperiod) | *     | An optional list of charging periods that can be used to calculate and verify the total cost. |
| total_cost        | Decimal           | 1     | The total cost (excluding VAT) of the session in the specified currency. This is the price that the eMSP will have to pay to the CPO. |
| status            | [SessionStatus](#sessionstatus) | 1     | The status of the session. |
| endpoints         | [Endpoint](https://github.com/ocpi/ocpi/blob/master/versions.md#endpoint-class) | *     | Lists the related endpoints to the session. These are specific for each party. See below for more information. |


##### ChargingPeriod *type*

| Property  | Type        | Card. | Description                              |
|-----------|-------------|-------|------------------------------------------|
| start_datetime       | DateTime       | 1     |  |
| end_datetime         | DateTime       | 1     |  |
| tariff_number        | string         | 1     |  |
| kwh                  | int            | 1     |  |
| cost                 | string         | 1     |  |
| max_power            | int            | 1     |  |


##### SessionStatus *enum*

| Property  | Description                                                                |
|-----------|----------------------------------------------------------------------------|
| PENDING   | The session is pending and has not yet started. This is the initial state. |
| ACTIVE    | The session is accepted and active.                                        |
| COMPLETED | The session has finished succesfully.                                      |
| INVALID   | The session is declared invalid and will not be billed.                    |
| DISPUTED  | The eMSP disputes the validity of the session. This status will have to be resolved manually. |


##### POST to /sessions

Create a new session in the eMSP backoffice by POSTing a [Session](#session) object.

The response contains a copy of the [Session](#session) object enriched with the **status** and **endpoints** fields and the **id** field filled.

The endpoints field contains the endpoints relevant to the session that was created.

Example:
```
"endpoints": [
  {"identifier": "uri", "url": "http://msp/sessions/345/"},
  {"identifier": "create_cdr", "url": "http://msp/sessions/345/create_cdr"}
]
```
---

### Sessions detail endpoint

Example: `/ocpi/msp/2.0/sessions/235`

The session detail endpoint is used to send updates for a specific session using the PATCH method.



##### PATCH to /sessions/{id}
Update the [Session](#session) object.

The response will contain the updated [Session](#session) object.

---

### CDR creation endpoint

Example: `/ocpi/msp/2.0/sessions/235/create_cdr`

The CDR creation endpoint is called with a POST method when the CPO wants to "seal" or "finalize" the session, which
signals to the eMSP that the current state of the session should be locked and that a CDR should be created from it.


##### POST to /sessions/{id}/create_cdr

Seals the [Session](#session) object and creates a new CDR from it.

The request should contain the complete, final session object.

The response will contain a sealed copy of the [Session](#session) object enriched with the **status** set to `COMPLETED`.
The "endpoints" field will point to the endpoint for handling the CDR.

Example:
```
"endpoints": [
  {"identifier": "uri", "url": "http://msp/cdrs/345/"}
]
```
---

### CDRs endpoint

Example: `/ocpi/msp/2.0/cdrs/`

The CDRs endpoint can be used to create or retrieve CDRs.

##### send GET to /cdrs/
Retrieves all CDRs.

The request should be encoded as `application/x-www-form-urlencoded`. The parameters are TBD.

The response should be a list of CDRs matching the query parameters.

##### send POST to /cdrs/
Creates a new CDR.

The request should contain the full, final CDR object.

The response should contain the CDR object with the fields `id`, `status` and `endpoints` correctly filled.


---


### CDR detail endpoint

Example: `/ocpi/msp/2.0/cdrs/235`

The CDR detail endpoint can be used for corrections of a CDR.

##### send DELETE to /cdrs/{id}
Sending a DELETE method will invalidate a CDR.

The response should contain the CDR object with the status INVALID.

##### send PUT to /cdrs/{id}
Corrects the CDR by sending a new one, thus invalidating the old one.

The request should contain the new correct CDR object.

The response should contain the new correct CDR object, with fields `id`, `status` and `endpoints` filled correctly.

---





