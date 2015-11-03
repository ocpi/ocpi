# _CDRs_ Business Object

A **Charge Detail Record** is the description of a concluded charging
session. The CDR is the only billing-relevant object.



## 1. Inheritances

*List all inheritors.*

### 1.1 Operator Inheritor

*Describe the purpose and singularity of this inheritor.*

### 1.2 Provider Inheritor

*Describe the purpose and singularity of this inheritor.*



## 2. Flow and Lifecycle

*Describe the status of the objects, how it is created and destroyed,
when and through which action it gets inherited. Name the owner. Explain
the purpose.*




## 3. Interfaces and endpoints

*Explain which interfaces are available and which party should implement
which one.*


### 3.1 Operator Interface

The CDRs endpoint can be used to create or retrieve CDRs.

Endpoint structure `/ocpi/cpo/cdrs/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | Receive all CDRs for the requesting provider.        |
| POST     | n/a                                                  |
| PUT      | n/a                                                  |
| PATCH    | n/a                                                  |
| DELETE   | n/a                                                  |


#### 3.1.1 GET Method

Retrieves all CDRs.

The request should be encoded as `application/x-www-form-urlencoded`.
The parameters are TBD.

The response should be a list of CDRs matching the query parameters.



### 3.2 Provider Interface

The CDRs endpoint can be used to create or retrieve CDRs.

Endpoint structure `/ocpi/msp/cdrs/` and `/ocpi/msp/cdrs/{cdr-id}/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | n/a                                                  |
| POST     | Create a new CDR.                                    |
| PUT      | Correct the CDR.                                     |
| PATCH    | n/a                                                  |
| DELETE   | Invalidate the CDR.                                  |


#### 3.2.1 POST Method

Creates a new CDR.

The request should contain the full, final CDR object.

The response should contain the CDR object with the fields `id`,
`status` and `endpoints` correctly filled.


#### 3.2.2 PUT Method

Corrects the CDR by sending a new one, thus invalidating the old one.

The request should contain the new correct CDR object.

The response should contain the new correct CDR object, with fields `id`, `status` and `endpoints` filled correctly.


#### 3.2.3 DELETE Method

Sending a DELETE method will invalidate a CDR.

The response should contain the CDR object with the status INVALID.



## 4. Object description

### 4.1 CDR Object

The *CDR* object describes the Charging Session and its costs. How these costs are build up etc. 

| Property         | Type           | Card. | Description                                                                                                       |
|------------------|----------------|-------|-------------------------------------------------------------------------------------------------------------------|
| id               | string(15)     | 1     | Uniquely identifies the CDR within the CPO's platform (and suboperator platforms).                                |
| start_date_time  | DateTime       | 1     | Start timestamp of the charging session                                                                           | 
| dimensions       | CdrDimension   | *     | List of applicable quantities that have impact on total costs.                                                    | 
| kwh              | decimal        | 1     | Amount of kWh charged                                                                                             | 
| location         | Location       | 1     | Location were the charging session took place, see: [Locations & EVSEs](bo_locations_and_evses.md)                | 
| evse             | EVSE           | 1     | EVSE used for this charging session, see: [Locations & EVSEs](bo_locations_and_evses.md)                          |
| connector_id     | string(15)     | 1     | Identifier of the connector used, relevant Connector Object is part of the Location Object provided with this CDR | 
| meter_id         | string(255)    | ?     | Identification of the Meter inside the Charge Point                                                               | 
| currency         | string(3)      | 1     | Currency of the CDR in ISO 4217 Code                                                                              | 
| tariffs          | Tariff         | *     | List of relevant tariff elements, see: [Tariffs](bo_tariffs.md)                                                   | 
| charging_periods | ChargingPeriod | *     | List of charging periods that make up this charging session. A session consist of 1 or more periodes with, each period has a different relevant Tariff | 
| total_cost       | decimal        | 1     | Total cost of this transaction                                                                                    | 


## 5. Data types

### 5.X CdrDimension

| Property        | Type          | Card. | Description                                   |
|-----------------|---------------|-------|-----------------------------------------------|
| type            | DimensionType | 1     | Type of cdr dimension, see: [Types](types.md) |
| volume          | decimal       | 1     | Duration of this period in seconds            |


### 5.X ChargingPeriod

A charging period consists of a start timestamp and a list of possible values that influence this period, for example: Amount of energy charged this period, maximum current during this period etc.

| Property        | Type         | Card. | Description                                        |
|-----------------|--------------|-------|----------------------------------------------------|
| start_date_time | DateTime     | 1     | Start timestamp of the charging period             |
| dimension       | CdrDimension | +     | List of relevant values for this charging period   |


