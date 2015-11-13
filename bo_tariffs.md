# _Tariffs_ module

**Module Identifier: tariffs**

The Tariff module gives eMSPs information over the tariffs used by the CPO.
 


## 1. Inheritances

N/A


## 2. Flow and Lifecycle

### 2.1 Push model

When the CPO creates Tariff(s) they push them to the eMSPs by calling [PUT](#321-put-method) on the eMSPs
Tariffs endpoint with the newly create Tariff(s)

Any changes to the Tariff(s) in the CPO system are send to the eMSP system by calling [PATCH](#322-patch-method)
on the eMSPs Tariffs endpoint with the updated Tariff(s).

When the CPO deletes Tariff(s), they will update the eMSPs systems by calling [DELETE](#323-delete-method)
on the eMSPs Tariffs endpoint, with a list of IDs of the Tariffs that are deleted.


### 2.2 Pull model

eMSPs who do not support the push model need to call
[GET](#311-get-method) on the CPOs Tariff endpoint to receive
all Tariffs, replacing the current list of known Tariffs with the newly received list.


## 3. Interfaces and endpoints

There is both a CPO and an eMSP interface for Tariffs. Advised is to use the push direction from eMSP to CPO during normal operation.
The eMSP interface is mend to be used when the CPO is not 100% sure the Tariff cache is correct anymore.


### 3.1 CPO Interface

The CPO Tariffs interface give the eMSP the ability to request all tariffs.

Example endpoint structure: `/ocpi/cpo/2.0/tariffs/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | Returns all Tariff Objects from the CPO              |
| POST     | n/a                                                  |
| PUT      | n/a                                                  |
| PATCH    | n/a                                                  |
| DELETE   | n/a                                                  |


#### 3.1.1 __GET__ Method

Fetch information about all Tariffs.
Any Tariffs, known in the eMSP system that are not provided in the response, should be removed in the eMSP system.


##### Data

The endpoint returns an object with list of valid Tariffs.

| Property  | Type                            | Card. | Description                              |
|-----------|---------------------------------|-------|------------------------------------------|
| tariffs   | [Tariff](#41-tariff-object)     | *     | List of all tariffs.                     |


### 3.2 eMSP Interface

The Tariff information can also be pushed to the eMSP, for this the following needs to be implemented.

Example endpoint structure: `/ocpi/emsp/2.0/tariffs/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | n/a                                                  |
| POST     | n/a                                                  |
| PUT      | Push new Tariff Objects to the eMSP                  |
| PATCH    | Update Tariff Objects with new information           |
| DELETE   | Remove Tariff Objects which is no longer valid       |


#### 3.2.1 __PUT__ Method

New created Tariff Objects are pushed from the CPO to the eMSP. 

##### Data

In the put request a list of new Tariff Objects is send.

| Property  | Type                            | Card. | Description                              |
|-----------|---------------------------------|-------|------------------------------------------|
| tariffs   | [Tariff](#41-tariff-object)     | *     | List of new tariffs.                     |


#### 3.2.2 __PATCH__ Method

Updated Tariff Objects are pushed from the CPO to the eMSP. 

##### Data

In the patch request a list of updated Tariff Objects is send.

| Property  | Type                            | Card. | Description                              |
|-----------|---------------------------------|-------|------------------------------------------|
| tariffs   | [Tariff](#41-tariff-object)     | *     | List of all tariffs.                     |


#### 3.2.3 __DELETE__ Method

Delete no longer valid Tariff Objects. 

##### Data

In the delete request a list of no longer valid Tariff ids is send.

| Property  | Type            | Card. | Description                                     |
|-----------|-----------------|-------|-------------------------------------------------|
| ids       | String(15)      | +     | List of id's of tariffs that should be deleted  |



## 4. Object description

### 4.1 Tariff Object

A Tariff Object consists of a list of one or more TariffElements, these elements can be used to create complex Tariff structures. 

| Property        | Type          | Card. | Description                                                                           |
|-----------------|---------------|-------|---------------------------------------------------------------------------------------|
| id              | string(15)    | 1     | Uniquely identifies the tariff within the CPOs platform (and suboperator platforms).  |
| currency        | string(3)     | 1     | Currency of this tariff, ISO 4217 Code                                                |
| elements        | TariffElement | +     | List of tariff elements                                                               |


## 5. Data types

### 5.1 DayOfWeek *enum*

| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| MONDAY       | Monday                                               |
| TUESDAY      | Tuesday                                              |
| WEDNESDAY    | Wednesday                                            |
| THURSDAY     | Thursday                                             |
| FRIDAY       | Friday                                               |
| SATURDAY     | Saturday                                             |
| SUNDAY       | Sunday                                               |


### 5.2 PriceComponent *class*

| Property        | Type          | Card. | Description                                      |
|-----------------|---------------|-------|--------------------------------------------------|
| type            | DimensionType | 1     | Type of tariff dimension, see: [Types](types.md) |
| price           | decimal       | 1     | price per unit for this tariff dimension         |
| step_size       | int           | 1     | Minimum amount to be billed. This unit will be billed in this step_size blocks. For example: if type is time and  step_size is 300, then time will be billed in blocks of 5 minutes, so if 6 minutes is used, 10 minutes (2 blocks of step_size) will be billed. |


### 5.3 TariffElement *class*

| Property         | Type               | Card. | Description                                                      |
|------------------|--------------------|-------|------------------------------------------------------------------|
| price_components | PriceComponent     | +     | List of price components that make up the pricing of this tariff |
| restrictions     | TariffRestrictions | ?     | List of tariff restrictions                                      |


### 5.4 TariffRestrictions *class*

| Property        | Type               | Card. | Description                                                                           |
|-----------------|--------------------|-------|---------------------------------------------------------------------------------------|
| start_time      | string(5)          | ?     | Start time of day, for example 13:30, valid from this time of the day                 |
| end_time        | string(5)          | ?     | End time of day, for example 19:45, valid until this time of the day                  |
| start_date      | string(10)         | ?     | Start date, for example: 2015-12-24, valid from this day                              |
| end_date        | string(10)         | ?     | End date, for example: 2015-12-27, valid until this day (excluding this day)          |
| min_kwh         | decimal            | ?     | Minimum used energy in kWh, for example 20, valid from this amount of energy is used  |                             
| max_kwh         | decimal            | ?     | Maximum used energy in kWh, for example 50, valid until this amount of energy is used |
| min_power       | decimal            | ?     | Minimum power in kW, for example 0, valid from this charging speed                    |
| max_power       | decimal            | ?     | Maximum power in kW, for example 20, valid up to this charging speed                  |
| min_duration    | int                | ?     | Minimum duration in seconds, valid for a duration from x seconds                      |
| max_duration    | int                | ?     | Maximum duration in seconds, valid for a duration up to x seconds                     |
| day_of_week     | DayOfWeek          | *     | Which day(s) of the week this tariff is valid                                         |



