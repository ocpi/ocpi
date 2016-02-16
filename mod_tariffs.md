# _Tariffs_ module

**Module Identifier: `tariffs`**

The Tariffs module gives eMSPs information about the tariffs used by the CPO.


## 1. Flow and Lifecycle

### 1.1 Push model

When the CPO creates a new Tariff they push them to the eMSPs by calling the [PUT](#222-put-method) on the eMSPs
Tariffs endpoint with the newly created Tariff object.

Any changes to the Tariff(s) in the CPO system can be send to the eMSP system by calling either [PUT](#222-put-method)
or [PATCH](#223-patch-method) on the eMSPs Tariffs endpoint with the updated Tariff object.

When the CPO deletes a Tariff, they will update the eMSPs systems by calling [DELETE](#224-delete-method)
on the eMSPs Tariffs endpoint, with the ID of the Tariff that is deleted.

When the CPO is not sure about the state or existence of a Tariff object in the eMSPs system, the 
CPO can call the [GET](#221-get-method) to validate the Tariff object in the eMSP system.   


### 1.2 Pull model

eMSPs who do not support the push model need to call
[GET](#211-get-method) on the CPOs Tariff endpoint to receive
all Tariffs, replacing the current list of known Tariffs with the newly received list.


## 2. Interfaces and endpoints

There is both a CPO and an eMSP interface for Tariffs. Advised is to use the push direction from CPO to eMSP during normal operation.
The CPO interface is meant to be used when the connection between 2 parties is established to retrieve the current list of Tariffs objects, and when the eMSP is not 100% sure the Tariff cache is still correct.


### 2.1 CPO Interface

The CPO Tariffs interface gives the eMSP the ability to request all tariffs.

Example endpoint structure: `/ocpi/cpo/2.0/tariffs/`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                 | Description                                          |
|------------------------|------------------------------------------------------|
| [GET](#211-get-method) | Returns all Tariff Objects from the CPO ([paginated](transport_and_format.md#get)) |
| POST                   | n/a                                                  |
| PUT                    | n/a                                                  |
| PATCH                  | n/a                                                  |
| DELETE                 | n/a                                                  |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.1.1 __GET__ Method

Fetch information about all Tariffs.

##### Request Parameters

This request is [paginated](transport_and_format.md#get), it supports the [pagination](transport_and_format.md#paginated-request) related URL parameters.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter  | Datatype                              | Required | Description                                                                   |
|------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| offset     | int                                   | no       | The offset of the first object returned. Default is 0.                        |
| limit      | int                                   | no       | Maximum number of objects to GET.                                             |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The endpoint returns an object with a list of valid Tariffs, the header will contain the [pagination](transport_and_format.md#paginated-response) related headers.

Any older information that is not specified in the response is considered as no longer valid.
Each object must contain all required fields. Fields that are not specified may be considered as null values.


<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Tariff](#31-tariff-object)     | *     | List of all tariffs.                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 2.2 eMSP Interface

Tariffs is a [client owned object](transport_and_format.md#client-owned-object-push), so the end-points need to contain the required extra fields: {[party_id](credentials.md#credentials-object)} and {[country_code](credentials.md#credentials-object)}.
Example endpoint structure: 
`/ocpi/emsp/2.0/tariffs/{country_code}/{party_id}/{tariff_id}` 

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                       | Description                                            |
|------------------------------|--------------------------------------------------------|
| [GET](#221-get-method)       | Retrieve a Location as it is stored in the eMSP system.|
| POST                         | n/a                                                    |
| [PUT](#222-put-method)       | Push new/updated Tariff object to the eMSP.            |
| [PATCH](#223-patch-method)   | Notify the eMSP of partial updates to a Tariff.        |
| [DELETE](#224-delete-method) | Remove Tariff object which is no longer valid          |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.1 __GET__ Method

If the CPO wants to check the status of a Tariff in the eMSP system it might GET the object from the eMSP system for validation purposes. The CPO is the owner of the objects, so it would be illogical if the eMSP system had a different status or was missing an object.

##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter         | Datatype                              | Required | Description                                                                   |
|-------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code      | [string](types.md#16-string-type)(2)  | yes      | Country code of the CPO requesting this PUT to the eMSP system.               |
| party_id          | [string](types.md#16-string-type)(3)  | yes      | Party ID (Provider ID) of the CPO requesting this PUT to the eMSP system.     |
| tariff_id         | [string](types.md#16-string-type)(15) | yes      | Tariff.id of the Tariff object to retrieve.                                   |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The response contains the requested object. 

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                                | Card. | Description                                                |
|-------------------------------------|-------|------------------------------------------------------------|
| [Tariff](#31-tariff-object)         | 1     | The requested Tariff object.                               |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.2 __PUT__ Method

New or updated Tariff objects are pushed from the CPO to the eMSP. 

##### Request Body

In the put request the new or updated Tariff object is sent.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Tariff](#31-tariff-object)     | 1     | New or updated Tariff object             |
<div><!-- ---------------------------------------------------------------------------- --></div>

##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter         | Datatype                              | Required | Description                                                                   |
|-------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code      | [string](types.md#16-string-type)(2)  | yes      | Country code of the CPO requesting this PUT to the eMSP system.               |
| party_id          | [string](types.md#16-string-type)(3)  | yes      | Party ID (Provider ID) of the CPO requesting this PUT to the eMSP system.     |
| tariff_id         | [string](types.md#16-string-type)(15) | yes      | Tariff.id of the (new) Tariff object (to replace).                            |
<div><!-- ---------------------------------------------------------------------------- --></div>

##### Example: New Tariff 2 euro per hour
```json
PUT To URL: https://www.server.com/ocpi/emsp/2.0/tariffs/NL/TNM/12

{
	"id": "12",
	"currency": "EUR",
	"elements": [{
		"price_components": [{
			"type": "TIME",
			"price": "2.00",
			"step_size": 300
		}]
	}]
}
```


#### 2.2.3 __PATCH__ Method

The PATCH method works the same as the [PUT](#222-put-method) method, except that the fields/objects that have to be updated have to be present, other fields/objects that are not specified are considered unchanged.

##### Example: Change Tariff to 2,50 
```json
PUT To URL: https://www.server.com/ocpi/emsp/2.0/tariffs/NL/TNM/12

{
	"elements": [{
		"price_components": [{
			"type": "TIME",
			"price": "2.50",
			"step_size": 300
		}]
	}]
}
```


#### 2.2.4 __DELETE__ Method

Delete a no longer valid Tariff object. 

##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter         | Datatype                              | Required | Description                                                                   |
|-------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code      | [string](types.md#16-string-type)(2)  | yes      | Country code of the CPO requesting this PUT to the eMSP system.               |
| party_id          | [string](types.md#16-string-type)(3)  | yes      | Party ID (Provider ID) of the CPO requesting this PUT to the eMSP system.     |
| tariff_id         | [string](types.md#16-string-type)(15) | yes      | Tariff.id of the Tariff object to delete.                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


## 3. Object description

### 3.1 _Tariff_ Object

A Tariff Object consists of a list of one or more TariffElements, these elements can be used to create complex Tariff structures. 
When the list of _elements_ contains more then 1 element, than the first tariff in the list with matching restrictions will be used.

It is advised to always set a "default" tariff, the last tariff in the list of _elements_ with no restriction. This acts as a fallback when
non of the TariffElements before this matches the current charging period.   

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property            | Type                                         | Card. | Description                                                                           |
|---------------------|----------------------------------------------|-------|---------------------------------------------------------------------------------------|
| id                  | [string](types.md#16-string-type)(15)        | 1     | Uniquely identifies the tariff within the CPOs platform (and suboperator platforms).  |
| currency            | [string](types.md#16-string-type)(3)         | 1     | Currency of this tariff, ISO 4217 Code                                                |
| tariff_alt_text     | [DisplayText](types.md#15-displaytext-class) | *     | List of multi language alternative tariff info text                                   |
| tariff_alt_url      | [URL](types.md#14_url_type)                  | ?     | Alternative URL to tariff info                                                        |
| elements            | [TariffElement](#43-tariffelement-class)     | +     | List of tariff elements                                                               |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### Examples

##### Simple Tariff example 2 euro per hour
```json
{
	"id": "12",
	"currency": "EUR",
	"elements": [{
		"price_components": [{
			"type": "TIME",
			"price": "2.00",
			"step_size": 300
		}]
	}]
}
```

##### Simple Tariff example with alternative multi language text
```json
{
	"id": "12",
	"currency": "EUR",
	"tariff_alt_text": [{
		"language": "en",
		"text": "2 euro p/hour"
	}, {
		"language": "nl",
		"text": "2 euro p/uur"
	}],
	"elements": [{
		"price_components": [{
			"type": "TIME",
			"price": "2.00",
			"step_size": 300
		}]
	}]
}
```


##### Simple Tariff example with alternative URL
```json
{
	"id": "12",
	"currency": "EUR",
	"tariff_alt_url": "https://company.com/tariffs/12",
	"elements": [{
		"price_components": [{
			"type": "TIME",
			"price": "2.00",
			"step_size": 300
		}]
	}]
}
```


##### Complex Tariff example
2.50 euro start tariff
1.00 euro per hour charging tariff for less than 32A (paid per 15 minutes)
2.00 euro per hour charging tariff for more than 32A on weekdays (paid per 10 minutes)
1.25 euro per hour charging tariff for more than 32A during the weekend (paid per 10 minutes)
Parking costs:
- Weekdays: between 09:00 and 18:00 : 5 euro (paid per 5 minutes) 
- Saturday: between 10:00 and 17:00 : 6 euro (paid per 5 minutes)

```json
{
	"id": "11",
	"currency": "EUR",
	"tariff_alt_url": "https://company.com/tariffs/11",
	"elements": [{
		"price_components": [{
			"type": "FLAT",
			"price": "2.50",
			"step_size": 1
		}]
	}, {
		"price_components": [{
			"type": "TIME",
			"price": "1.00",
			"step_size": "900"
		}],
		"restrictions": [{
			"max_power": "32.00"
		}]
	}, {
		"price_components": [{
			"type": "TIME",
			"price": "2.00",
			"step_size": "600"
		}],
		"restrictions": [{
			"min_power": "32.00",
			"day_of_week": ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY"]
		}]
	}, {
		"price_components": [{
			"type": "TIME",
			"price": "1.25",
			"step_size": "600"
		}],
		"restrictions": [{
			"min_power": "32.00",
			"day_of_week": ["SATURDAY", "SUNDAY"]
		}]
	}, {
		"price_components": [{
			"type": "PARKING_TIME",
			"price": "5.00",
			"step_size": "300"
		}],
		"restrictions": [{
			"start_time": "09:00",
			"end_time": "18:00",
			"day_of_week": ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY"]
		}]
	}, {
		"price_components": [{
			"type": "PARKING_TIME",
			"price": "6.00",
			"step_size": "300"
		}],
		"restrictions": [{
			"start_time": "10:00",
			"end_time": "17:00",
			"day_of_week": ["SATURDAY"]
		}]
	}]
}
```


## 4. Data types

### 4.1 DayOfWeek *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| MONDAY       | Monday                                               |
| TUESDAY      | Tuesday                                              |
| WEDNESDAY    | Wednesday                                            |
| THURSDAY     | Thursday                                             |
| FRIDAY       | Friday                                               |
| SATURDAY     | Saturday                                             |
| SUNDAY       | Sunday                                               |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 4.2 PriceComponent *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property        | Type                                            | Card. | Description                                      |
|-----------------|-------------------------------------------------|-------|--------------------------------------------------|
| type            | [DimensionType](types.md#14-dimensiontype-enum) | 1     | Type of tariff dimension, see: [Types](types.md#types) |
| price           | [decimal](types.md#13-decimal-type)             | 1     | price per unit for this tariff dimension         |
| step_size       | int                                             | 1     | Minimum amount to be billed. This unit will be billed in this step_size blocks. For example: if type is time and  step_size is 300, then time will be billed in blocks of 5 minutes, so if 6 minutes is used, 10 minutes (2 blocks of step_size) will be billed. |
<div><!-- ---------------------------------------------------------------------------- --></div>

### 4.3 TariffElement *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property                 | Type                                               | Card. | Description                                                      |
|--------------------------|----------------------------------------------------|-------|------------------------------------------------------------------|
| price_components         | [PriceComponent](#42-pricecomponent-class)         | +     | List of price components that make up the pricing of this tariff |
| restrictions             | [TariffRestrictions](#44-tariffrestrictions-class) | ?     | List of tariff restrictions                                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 4.4 TariffRestrictions *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property                | Type                                  | Card. | Description                                                                           |
|-------------------------|---------------------------------------|-------|---------------------------------------------------------------------------------------|
| start_time              | [string](types.md#16-string-type)(5)  | ?     | Start time of day, for example 13:30, valid from this time of the day. Must be in 24h format with leading zeros. Hour/Minute separator: ":" Regex: [0-2][0-9]:[0-5][0-9] |
| end_time                | [string](types.md#16-string-type)(5)  | ?     | End time of day, for example 19:45, valid until this time of the day. Same syntax as start_time |
| start_date              | [string](types.md#16-string-type)(10) | ?     | Start date, for example: 2015-12-24, valid from this day                              |
| end_date                | [string](types.md#16-string-type)(10) | ?     | End date, for example: 2015-12-27, valid until this day (excluding this day)          |
| min_kwh                 | [decimal](types.md#13-decimal-type)   | ?     | Minimum used energy in kWh, for example 20, valid from this amount of energy is used  |                             
| max_kwh                 | [decimal](types.md#13-decimal-type)   | ?     | Maximum used energy in kWh, for example 50, valid until this amount of energy is used |
| min_power               | [decimal](types.md#13-decimal-type)   | ?     | Minimum power in kW, for example 0, valid from this charging speed                    |
| max_power               | [decimal](types.md#13-decimal-type)   | ?     | Maximum power in kW, for example 20, valid up to this charging speed                  |
| min_duration            | int                                   | ?     | Minimum duration in seconds, valid for a duration from x seconds                      |
| max_duration            | int                                   | ?     | Maximum duration in seconds, valid for a duration up to x seconds                     |
| day_of_week             | [DayOfWeek](#41-dayofweek-enum)       | *     | Which day(s) of the week this tariff is valid                                         |
<div><!-- ---------------------------------------------------------------------------- --></div>

