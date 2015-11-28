# _CDRs_ module

**Module Identifier: cdrs**

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

Any changes to the CDR(s) in the CPO system are send to the eMSP system by calling [PUT](#322-put-method)
on the eMSPs CDRs endpoint with the complete updated CDR(s).

CDRs cannot be deleted, they can only be made invalid, by setting the status to: invalid, and then resending the same CDR by calling [PUT](#322-put-method)


### 2.2 Pull model

eMSPs who do not support the push model need to call
[GET](#311-get-method) on the CPOs CDRs endpoint to receive
all CDRs.


## 3. Interfaces and endpoints

There is both a CPO and an eMSP interface for CDRs. Depening on business requirements parties can decide to use
the CPO Interface/Get model, or the eMSP Interface/Push model, or both. 
Push is the preferred model to use, the eMSP will receive CDRs when created by the CPO.

### 3.1 CPO Interface

The CDRs endpoint can be used to create or retrieve CDRs.

Example endpoint structure: `/ocpi/cpo/2.0/cdrs/?date_from=xxx&date_to=yyy`

| Method                  | Description                                                                      |
|-------------------------|----------------------------------------------------------------------------------|
| [GET](#311-get-method)  | Fetch CDRs of charging sessions started between the {date_from} and {date_to}    |
| POST                    | n/a                                                                              |
| PUT                     | n/a                                                                              |
| PATCH                   | n/a                                                                              |
| DELETE                  | n/a                                                                              |


#### 3.1.1 __GET__ Method

Fetch CDRs from the CPO systems. Only CDRs of charging sessions with a start date/time between the given date_from and date_to will be returned.

| Parameter  | Datatype                              | Required | Description                                                                   |
|------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| date_from  | [DateTime](types.md#11_datetime_type) | yes      | Begin charging session start Date/Time of CDRs to fetch.                      |
| date_to    | [DateTime](types.md#11_datetime_type) | no       | End charging session start Date/Time of CDRs to fetch, if omitted all CDRs up to now are request to be returned. |

_NOTE: The CPO is allowed to return a (not specified) maximum amount of CDRs, to prevent overloading there system. In this version of OCPI it is not possible to detect if the CPO returned not all CDRs that match the filter._  

##### Data

The endpoint returns a list of valid CDRs.

| Property  | Type                            | Card. | Description                              |
|-----------|---------------------------------|-------|------------------------------------------|
| cdrs      | [CDR](#41-cdr-object)           | *     | List of CDRs.                            |



### 3.2 eMSP Interface

The CDRs endpoint can be used to create, update or delete CDRs.

Example endpoint structure: `/ocpi/emsp/2.0/cdrs/` and `/ocpi/emsp/2.0/cdrs/{cdr-id}/`

| Method                   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET                      | n/a                                                  |
| [POST](#321-post-method) | Create a new CDR.                                    |
| [PUT](#322-put-method)   | Correct the CDR with id {cdr-id} by replacing it.    |
| PATCH                    | n/a                                                  |
| DELETE                   | n/a (Use PUT, CDRs cannot be removed)                |


#### 3.2.1 POST Method

Creates a new CDR.

The post method should contain the full, final CDR object(s).


##### Data

In the post request a list of new CDR Objects is send.

| Property  | Type                            | Card. | Description                              |
|-----------|---------------------------------|-------|------------------------------------------|
| cdrs      | [CDR](#41-cdr-object)           | *     | List of CDRs.                            |


#### 3.2.2 PUT Method

Corrects the CDR by sending a new one, thus invalidating the old one.

The put method should contain the new correct CDR object(s).


##### Data

In the put request a list updated CDR Objects is send.

| Property  | Type                            | Card. | Description                              |
|-----------|---------------------------------|-------|------------------------------------------|
| cdrs      | [CDR](#41-cdr-object)           | *     | List of CDRs.                            |


## 4. Object description

### 4.1 CDR Object

The *CDR* object describes the Charging Session and its costs. How these costs are build up etc. 

| Property         | Type                                                     | Card. | Description                                                                                                       |
|------------------|----------------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------|
| id               | string(15)                                               | 1     | Uniquely identifies the CDR within the CPOs platform (and suboperator platforms).                                  |
| start_date_time  | [DateTime](types.md#11_datetime_type)                    | 1     | Start timestamp of the charging session                                                                                                                                                                 | 
| dimensions       | [CdrDimension](51-cdrdimension-class)                    | +     | List of applicable quantities that have impact on total costs.                                                 | 
| kwh              | [Decimal](types.md#12_decimal_type)                      | 1     | Amount of kWh charged                                                                                             | 
| location         | [Location](bo_locations_and_evses.md#41-location-object) | 1     | Location were the charging session took place, see: [Locations & EVSEs](bo_locations_and_evses.md)             | 
| evse             | [EVSE](bo_locations_and_evses.md#42-evse-object)         | 1     | EVSE used for this charging session, see: [Locations & EVSEs](bo_locations_and_evses.md)                         |
| connector_id     | string(15)                                               | 1     | Identifier of the connector used, relevant Connector Object is part of the Location Object provided with this CDR | 
| meter_id         | string(255)                                              | ?     | Identification of the Meter inside the Charge Point                                                                  | 
| currency         | string(3)                                                | 1     | Currency of the CDR in ISO 4217 Code                                                                                                                                   | 
| tariffs          | [Tariff](bo_tariffs.md#41-tariff-object)                 | *     | List of relevant tariff elements, see: [Tariffs](bo_tariffs.md)                                               | 
| status           | [CdrStatus](#52-cdrstatus-enum)                          | 1     | Status of this CDR                                                   | 
| charging_periods | [ChargingPeriod](#53-chargingperiod-class)               | +     | List of charging periods that make up this charging session. A session consist of 1 or more periodes with, each period has a different relevant Tariff | 
| total_cost       | [Decimal](types.md#12_decimal_type)                      | 1     | Total cost of this transaction                                                                                    | 


## 5. Data types

### 5.1 CdrDimension *class*

| Property        | Type                                            | Card. | Description                                    |
|-----------------|-------------------------------------------------|-------|------------------------------------------------|
| type            | [DimensionType](types.md#13-dimensiontype-enum) | 1     | Type of cdr dimension, see: [Types](types.md). |
| volume          | [Decimal](types.md#12_decimal_type)             | 1     | Duration of this period in seconds.            |


### 5.2 CdrStatus *enum*

| Value        | Description                                                                             |
|--------------|-----------------------------------------------------------------------------------------|
| valid        | This CDR is complete and valid.                                                         |
| incomplete   | This is an incomplete CDR, not all information is (yet) available to complete this CDR. |
| invalid      | This CDR is no longer valid / invalid.                                                  |


### 5.3 ChargingPeriod *class*

A charging period consists of a start timestamp and a list of possible values that influence this period, for example: Amount of energy charged this period, maximum current during this period etc.

| Property        | Type                             | Card. | Description                                         |
|-----------------|----------------------------------|-------|-----------------------------------------------------|
| start_date_time | [DateTime](types.md#11_datetime) | 1     | Start timestamp of the charging period.             |
| dimension       | CdrDimension                     | +     | List of relevant values for this charging period.   |


