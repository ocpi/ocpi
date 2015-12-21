# _Tariffs_ module

**Module Identifier: tariffs**

The Tariffs module gives eMSPs information over the tariffs used by the CPO.
 


## 1. Inheritances

N/A


## 2. Flow and Lifecycle

### 2.1 Push model

When the CPO creates Tariff(s) they push them to the eMSPs by calling [POST](#321-post-method) on the eMSPs
Tariffs endpoint with the newly create Tariff(s)

Any changes to the Tariff(s) in the CPO system are send to the eMSP system by calling [PUT](#322-put-method)
on the eMSPs Tariffs endpoint with the updated Tariff(s).

When the CPO deletes a Tariff, they will update the eMSPs systems by calling [DELETE](#323-delete-method)
on the eMSPs Tariffs endpoint, with the ID of the Tariff that is deleted.


### 2.2 Pull model

eMSPs who do not support the push model need to call
[GET](#311-get-method) on the CPOs Tariff endpoint to receive
all Tariffs, replacing the current list of known Tariffs with the newly received list.


## 3. Interfaces and endpoints

There is both a CPO and an eMSP interface for Tariffs. Advised is to use the push direction from CPO to eMSP during normal operation.
The CPO interface is mend to be used when the eMSP is not 100% sure the Tariff cache is correct anymore.


### 3.1 CPO Interface

The CPO Tariffs interface give the eMSP the ability to request all tariffs.

Example endpoint structure: `/ocpi/cpo/2.0/tariffs/`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                 | Description                                          |
| ---------------------- | ---------------------------------------------------- |
| [GET](#311-get-method) | Returns all Tariff Objects from the CPO              |
| POST                   | n/a                                                  |
| PUT                    | n/a                                                  |
| PATCH                  | n/a                                                  |
| DELETE                 | n/a                                                  |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 3.1.1 __GET__ Method

Fetch information about all Tariffs.
Any Tariffs, known in the eMSP system that are not provided in the response, should be removed in the eMSP system.


##### Data

The endpoint returns an object with list of valid Tariffs.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Tariff](#41-tariff-object)     | *     | List of all tariffs.                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 3.2 eMSP Interface

The Tariff information can also be pushed to the eMSP, for this the following needs to be implemented.

Example endpoint structure: `/ocpi/emsp/2.0/tariffs/` and `/ocpi/emsp/2.0/tariffs/{tariff_id}` 

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                       | Description                                          |
| ---------------------------- | ---------------------------------------------------- |
| GET                          | n/a                                                  |
| [POST](#321-post-method)     | Push new Tariff Objects to the eMSP                  |
| [PUT](#322-put-method)       | Update Tariff Objects with new information           |
| PATCH                        | n/a                                                  |
| [DELETE](#323-delete-method) | Remove Tariff Object which is no longer valid        |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 3.2.1 __POST__ Method

New created Tariff Objects are pushed from the CPO to the eMSP. 

##### Data

In the post request a list of new Tariff Objects is send.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Tariff](#41-tariff-object)     | *     | List of new tariffs.                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 3.2.2 __PUT__ Method

Updated Tariff Objects are pushed from the CPO to the eMSP, to replace the current Tariff in the eMSP. 

##### Data

In the put request a list of updated Tariff Objects is send.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Tariff](#41-tariff-object)     | *     | List of all tariffs.                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 3.2.3 __DELETE__ Method

Delete no longer valid Tariff Object. 

##### Parameters

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter  | Datatype                              | Required | Description                               |
|------------|---------------------------------------|----------|-------------------------------------------|
| tariff_id  | [string](types.md#16-string-type)(15) | yes      | ID of the Tariff to be deleted            |
<div><!-- ---------------------------------------------------------------------------- --></div>


## 4. Object description

### 4.1 Tariff Object

A Tariff Object consists of a list of one or more TariffElements, these elements can be used to create complex Tariff structures. 
When the list of _elements_ contains more then 1 element, then the first tariff in the list with matching restrictions will be used.

It is advised to always set a "default" tariff, the last tariff in the list of _elements_ with no restriction. This acts as a fallback when
non the the TariffElements before this matches the current charging period.   

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property        | Type                                         | Card. | Description                                                                           | 
|-----------------|----------------------------------------------|-------|---------------------------------------------------------------------------------------| 
| id              | [string](types.md#16-string-type)(15)        | 1     | Uniquely identifies the tariff within the CPOs platform (and suboperator platforms).  | 
| currency        | [string](types.md#16-string-type)(3)         | 1     | Currency of this tariff, ISO 4217 Code                                                | 
| tariff_alt_text | [DisplayText](types.md#15-displaytext-class) | *     | List of multi language alternative tariff info text                                   | 
| tariff_alt_url  | [URL](types.md#14_url_type)                  | ?     | Alternative URL to tariff info                                                        | 
| elements        | [TariffElement](#53-tariffelement-class)     | +     | List of tariff elements                                                               | 
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
Parking:
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


## 5. Data types

### 5.1 DayOfWeek *enum*

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


### 5.2 PriceComponent *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property        | Type                                            | Card. | Description                                      |
|-----------------|-------------------------------------------------|-------|--------------------------------------------------|
| type            | [DimensionType](types.md#14-dimensiontype-enum) | 1     | Type of tariff dimension, see: [Types](types.md) |
| price           | [decimal](types.md#13-decimal-type)             | 1     | price per unit for this tariff dimension         |
| step_size       | int                                             | 1     | Minimum amount to be billed. This unit will be billed in this step_size blocks. For example: if type is time and  step_size is 300, then time will be billed in blocks of 5 minutes, so if 6 minutes is used, 10 minutes (2 blocks of step_size) will be billed. |
<div><!-- ---------------------------------------------------------------------------- --></div>

### 5.3 TariffElement *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property         | Type                                               | Card. | Description                                                      |
|------------------|----------------------------------------------------|-------|------------------------------------------------------------------|
| price_components | [PriceComponent](#52-pricecomponent-class)         | +     | List of price components that make up the pricing of this tariff |
| restrictions     | [TariffRestrictions](#54-tariffrestrictions-class) | ?     | List of tariff restrictions                                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 5.4 TariffRestrictions *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property        | Type                                  | Card. | Description                                                                           |
|-----------------|---------------------------------------|-------|---------------------------------------------------------------------------------------|
| start_time      | [string](types.md#16-string-type)(5)  | ?     | Start time of day, for example 13:30, valid from this time of the day                 |
| end_time        | [string](types.md#16-string-type)(5)  | ?     | End time of day, for example 19:45, valid until this time of the day                  |
| start_date      | [string](types.md#16-string-type)(10) | ?     | Start date, for example: 2015-12-24, valid from this day                              |
| end_date        | [string](types.md#16-string-type)(10) | ?     | End date, for example: 2015-12-27, valid until this day (excluding this day)          |
| min_kwh         | [decimal](types.md#13-decimal-type)   | ?     | Minimum used energy in kWh, for example 20, valid from this amount of energy is used  |                             
| max_kwh         | [decimal](types.md#13-decimal-type)   | ?     | Maximum used energy in kWh, for example 50, valid until this amount of energy is used |
| min_power       | [decimal](types.md#13-decimal-type)   | ?     | Minimum power in kW, for example 0, valid from this charging speed                    |
| max_power       | [decimal](types.md#13-decimal-type)   | ?     | Maximum power in kW, for example 20, valid up to this charging speed                  |
| min_duration    | int                                   | ?     | Minimum duration in seconds, valid for a duration from x seconds                      |
| max_duration    | int                                   | ?     | Maximum duration in seconds, valid for a duration up to x seconds                     |
| day_of_week     | [DayOfWeek](#51-dayofweek-enum)       | *     | Which day(s) of the week this tariff is valid                                         |
<div><!-- ---------------------------------------------------------------------------- --></div>

