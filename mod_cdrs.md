# _CDRs_ module

**Module Identifier: `cdrs`**

A **Charge Detail Record** is the description of a concluded charging
session. The CDR is the only billing-relevant object.
CDRs are send from the CPO to the eMSP after the charging session has ended.
There is no requirement to send CDRs semi-realtime, it is seen as good practice to send them
ASAP. But if there is an agreement between parties to send then for example once a month, that is also allowed by OCPI.


## 1. Inheritances

N/A

## 2. Flow and Lifecycle

### 2.1 Push model

When the CPO creates CDR(s) they push them to the eMSPs by calling [POST](#321-post-method) on the eMSPs
CDRs endpoint with the newly create CDRs(s)

CDRs should contain enough information (dimensions) to allow the eMSP to validate the total costs. 
It is advised to send enough information to the eMSP so it might calculate its own costs for billing their customer. An eMSP might have a very different contract/pricing model with the EV driver then the tariff structure from the CPO.

_NOTE: CDRs cannot not yet be updated or removed. This might be added in a future version of OCPI._

### 2.2 Pull model

eMSPs who do not support the push model need to call
[GET](#311-get-method) on the CPOs CDRs endpoint to receive a list of CDRs.


## 3. Interfaces and endpoints

There is both a CPO and an eMSP interface for CDRs. Depening on business requirements parties can decide to use
the CPO Interface/Get model, or the eMSP Interface/Push model, or both. 
Push is the preferred model to use, the eMSP will receive CDRs when created by the CPO.

### 3.1 CPO Interface

The CDRs endpoint can be used to create or retrieve CDRs.

Example endpoint structure: `/ocpi/cpo/2.0/cdrs/?date_from=xxx&date_to=yyy`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                  | Description                                                                      |
|-------------------------|----------------------------------------------------------------------------------|
| [GET](#311-get-method)  | Fetch CDRs of charging sessions started between the {date_from} and {date_to} ([paginated](transport_and_format.md#get))    |
| POST                    | n/a                                                                              |
| PUT                     | n/a                                                                              |
| PATCH                   | n/a                                                                              |
| DELETE                  | n/a                                                                              |
<div><!-- ---------------------------------------------------------------------------- --></div>

#### 3.1.1 __GET__ Method

Fetch CDRs from the CPO systems. If additional parameters: {date_from} and/or {date_to} are provided, only CDRs of charging sessions with a start date/time between the given date_from and date_to will be returned.

This request is [paginated](transport_and_format.md#get), so also supports the [pagination](transport_and_format.md#paginated-request) related URL parameters.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter  | Datatype                              | Required | Description                                                                   |
|------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| date_from  | [DateTime](types.md#12_datetime_type) | no       | Begin charging session start Date/Time of CDRs to fetch.                      |
| date_to    | [DateTime](types.md#12_datetime_type) | no       | End charging session start Date/Time of CDRs to fetch, if omitted all CDRs up to now are request to be returned. |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The endpoint returns a list of CDRs matching the given parameters in the GET request, the header will contain the [pagination](transport_and_format.md#paginated-response) related headers. 

Any older information that is not specified in the response is considered as no longer valid.
Each object must contain all required fields. Fields that are not specified may be considered as null values.


<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter | Datatype              | Card. | Description                                                         |
|-----------|-----------------------|-------|---------------------------------------------------------------------|
| CDRs      | [CDR](#41-cdr-object) | *     | List of CDRs.                                                       |
<div><!-- ---------------------------------------------------------------------------- --></div>

### 3.2 eMSP Interface

The CDRs endpoint can be used to create, update or delete CDRs.

Example endpoint structure: `/ocpi/emsp/2.0/cdrs/` and `/ocpi/emsp/2.0/cdrs/{cdr-id}/`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                   | Description                                          |
| ------------------------ | ---------------------------------------------------- |
| GET                      | n/a                                                  |
| [POST](#321-post-method) | Create a new CDR.                                    |
| PUT                      | n/a                                                  |
| PATCH                    | n/a                                                  |
| DELETE                   | n/a (Use PUT, CDRs cannot be removed)                |
<div><!-- ---------------------------------------------------------------------------- --></div>

#### 3.2.1 POST Method

Creates a new CDR.

The post method should contain the full, final CDR object(s).


##### Data

In the post request a list of new CDR Objects is send.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [CDR](#41-cdr-object)           | *     | List of CDRs.                            |
<div><!-- ---------------------------------------------------------------------------- --></div>

## 4. Object description

### 4.1 CDR Object

The *CDR* object describes the Charging Session and its costs. How these costs are build up etc. 

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property                             | Type                                                     | Card. | Description                                                                                                                    |
|--------------------------------------|----------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------------------------------|
| id                                   | [CiString](types.md#12-cistring-type)(15)                | 1     | Uniquely identifies the CDR within the CPOs platform (and suboperator platforms).                                              |
| start_date_time                      | [DateTime](types.md#12-datetime-type)                    | 1     | Start timestamp of the charging session                                                                                        |
| stop_date_time                       | [DateTime](types.md#12-datetime-type)                    | ?     | Stop timestamp of the charging session                                                                                         |
| auth_id                              | [string](types.md#16-string-type)(32)                    | 1     | Reference to a token, identified by the auth_id field of the [Token](mod_tokens.md#41_token)                                   |
| auth_method                          | [AuthMethod](#51-authmethod-enum)                        | 1     | Method used for authentication.                                                                                                |
| location                             | [Location](mod_locations.md#41-location-object)          | 1     | Location were the charging session took place, see: [Locations & EVSEs](mod_locations.md#locations-and-evses-module)           |
| evse                                 | [EVSE](mod_locations.md#42-evse-object)                  | 1     | EVSE used for this charging session, see: [Locations & EVSEs](mod_locations.md#locations-and-evses-module)                     |   
| connector_id                         | [string](types.md#16-string-type)(15)                    | 1     | Identifier of the connector used, relevant Connector Object is part of the Location Object provided with this CDR              |
| meter_id                             | [string](types.md#16-string-type)(255)                   | ?     | Identification of the Meter inside the Charge Point                                                                            |
| currency                             | [string](types.md#16-string-type)(3)                     | 1     | Currency of the CDR in ISO 4217 Code                                                                                           |
| tariffs                              | [Tariff](mod_tariffs.md#41-tariff-object)                | *     | List of relevant tariff elements, see: [Tariffs](mod_tariffs.md#tariffs-module)                                                |
| charging_periods                     | [ChargingPeriod](#53-chargingperiod-class)               | +     | List of charging periods that make up this charging session. A session consist of 1 or more periodes with, each period has a different relevant Tariff |
| total_cost                           | [decimal](types.md#13-decimal-type)                      | 1     | Total cost of this transaction                                                                                                 |
| total_usage                          | [CdrDimension](#52-cdrdimension-class)                   | *     | List of total usage elements, for example: total parking time and total energy charged                                         |
| remark                               | [string](types.md#16-string-type)(255)                   | ?     | Optional remark, can be used to provide addition human readable information to the CDR, for example: reason why a transaction was stopped.|
<div><!-- ---------------------------------------------------------------------------- --></div>

## 5. Data types

### 5.1 AuthMethod *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Value            | Description                                                                             |
|------------------|-----------------------------------------------------------------------------------------|
| AUTH_REQUEST     | Authentication request from the eMSP                                                    |
| WHITELIST        | Whitelist used to authenticate, no request done to the eMSP                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

### 5.2 CdrDimension *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property        | Type                                            | Card. | Description                                                                 |
|-----------------|-------------------------------------------------|-------|-----------------------------------------------------------------------------|
| type            | [DimensionType](types.md#14-dimensiontype-enum) | 1     | Type of cdr dimension                                                       |
| volume          | [decimal](types.md#13-decimal-type)             | 1     | Volume of the dimension consumed, measured according to the dimension type. |
<div><!-- ---------------------------------------------------------------------------- --></div>

### 5.3 ChargingPeriod *class*

A charging period consists of a start timestamp and a list of possible values that influence this period, for example: Amount of energy charged this period, maximum current during this period etc.

<div><!-- -------------------------------------------------------------------------------- --></div>
| Property               | Type                                   | Card. | Description                                                                  |
|------------------------|----------------------------------------|-------|------------------------------------------------------------------------------|
| start_date_time        | [DateTime](types.md#12-datetime-type)  | 1     | Start timestamp of the charging period. This period ends when a next period starts, the last period ends when the session ends. |
| dimensions             | [CdrDimension](#52-cdrdimension-class) | +     | List of relevant values for this charging period.                                                                               |
<div><!-- -------------------------------------------------------------------------------- --></div>

