Title:  OCPI & NDR 1.0
Author: Olger Warnier <o.warnier@thenewmotion.com>, Dan Brooke <d.brooke@thenewmotion.com>
Date:   May 6th, 2014
Version:  0.3

# OCPI+CPNS & NDR Interface 0.3

**OCPI** Open Chargepoint Interface  
**NDR** Notification Detail Record 

## Introduction and background
This standard is built in order to find chargepoints, their details and stay up to date with their active state. 

Starting in 2009, e-laad foundation and the forerunner of the eViolin association specified 2 standards in order to retrieve chargepoint details and active state. These are called the VAS interface and the Amsterdam interface. 
In 2011, eViolin combined these 2 interface into the OCPI interface allowing other parties to fetch chargepoint information and active state. 

Currently, OCPI is extended with the Notification interface (NDR) that is already in use by different eViolin members. Pricing information is also added to the interface in order to allow for chargestation pricing. 

## OCPI Interface operations
| Operation             | Purpose                                                          |
| :-------------------- | :--------------------------------------------------------------- |
| Find Chargepoints     | Fetch a series of chargepoints given a number of search criteria |
| Subscribe to updates  | Subscribe to status updates for chargepoints based on search criteria |
| Unsubscribe from updates| Unsubscribe to status updates for a list of chargepoints         |
| Subscription status   | Get the list of chargepoints currently subscribed to             |

Many of the details for chargepoints are defined as enumerations and types used within the domain of EV charging. This document makes use of the OCPP2 spec for it's types and enumerations. 

Subscription to updates allows the caller to specify an endpoint address that will receive pushed messages. This endpoint needs to implement the NDR specified interface in order to receive messages correctly. Guaranteed message delivery may or may not be implemented, that is a decision up to the parties involved. Guaranteed message delivery SHOULD NOT put additional requirements or changes on the specified NDR format. 

## Find Chargepoints
### request
Fetch a series of chargepoints given a number of search criteria. 

Available search criteria:

| Criteria              | Optional | Possible values                                     | 
|:--------------------- | -------- | :-------------------------------------------------- |
| area                  | o | GPS coordinates of NE and SW corners                       |
| operators             | o | List of codes of the operator(s) to get chargepoints for   |
| vehicleType           | o | Type of vehicle to get chargepoints for (Car,Bike,Boat)    |
| authorizationType     | o | Chargepoints with certain type(s) of authorization         |

### response
The response contains a list of chargepoints matching the search criteria or an error message when the search failed. 
Chargepoints contain the following information

 * identifier
 * name: human readable form of the identifier
 * operator
	* identifier
	* description (optional)
	* phone no (optional)
	* url (optional)
 * connectors (list)
	* type: enumeration (see ConnectorType specification in OCPP2.0)
	* chargeProtocol:  enumeration (Unknown, Mode3, CHAdeMO, ISO15118, Uncontrolled)
	* status: enumeration (Available, Occupied, Charging, OutOfService)
	* power (replaces enum of DC50kWh / AC11kWh etc etc)
		* current (AC_1_Phase, AC_2_Phase, AC_3_Phase, DC)
		* voltage
		* amperage
	* pricingSchemes (list of available options)
		* description: human readable form indicating this scheme
		* startDate: ISO8601 date from this pricing scheme is valid (inclusive)
		* expiryDate: ISO8601 date until this pricing scheme is valid (inclusive)
		* tariff (list of components that build the price)
			* validityRule: periodType (enum: Charging, Parking), time (iCalendar RRULE)
			* description: human readable form of this part of the tariff
			* pricingUnit: enumeration of types of pricing (kWhToEV, OccupancyHours, Session see OCPP2)
			* currency: ISO 4217 code for currency
			* pricePerUnit: amount (in smallest unit for relevant currency with an additional two decimal places, incl VAT.  e.g. euros = 0.2343, japanese yen = 45.34)
			* taxPct: percentage of tax 
 * reservedParking: integer with amount of reserved parking spaces for EV charging. 
 * vehicleType enumeration: Car, Bike, Boat (default = Car)
 * authorizationTypes (list)
	* type: enumeration that described allowed identification (CIR, Bank, SMS, E-Clearing, Hubject, Provider App, Operator App, None (always usable)) 
	* description: human readable description
 * location
	* address: address of the entry location in order to reach the chargepoint
	* entryLocation: GPS coordinates in order to reach the chargepoint (e.g. at a parking)
	* chargepointLocation: GPS coordinates of the chargepoint
	* floor (0 = ground floor)
	* note: human readable note to help charging
	* pictures: list of URLs (should be publicly available) 
 * availability
 	* time (iCalendar RRULE, can be used e.g. by a mobile app so it does not show you a charge point that is currently closed)
	* description (Opening days / hours in plain text)
	* restrictions (in text) 
 

## Subscribe
### request
Fetch a series of chargepoints given a number of search criteria and subscribe to real-time status updates.

Available search criteria:

| Criteria              | Optional | Possible values                                     | 
|:--------------------- | -------- | :-------------------------------------------------- |
| area                  | o | GPS coordinates of NE and SW corners                       |
| operators             | o | List of codes of the operator(s) to get chargepoints for   |
| vehicleType           | o | Type of vehicle to get chargepoints for (Car,Bike,Boat)    |
| authorizationType     | o | Return chargepoints with certain type(s) of authorization  |
| identifier(s)         | o | Return status updates for a (list of ) specific chargepoint (s) |
 
The request must also contain the endpoint URL for delivering the NDR messages.  It may also include information to authenticate the user, if this is provided then the callbacks will contain contractIds for events relating to cards the user has access to.

Please note that the one providing this interface MAY put restrictions on the points that you will retrieve status updates for.  It is advised to check the availability of the NDR interface at registration

### response
The response contains a list of chargepoints (identifiers) that will be publishing events to the given endpoint, as well as a token id that can be used in future to validate received NDRs.

When the request is invalid or raised an error condition, an error message is returned. 

### NDR callback interface

This interface is implemented at the receiver side (the one that called the OCPI interface with a subscribe needs to implement this interface for receiving the NDR calls)

This interface will receive:

 * operator : code of the operator
 * tokenId : tokenId that matches the one returned in the subscribe response
 * chargePointIdentifier: unique identifier of the chargepoint
 * connectorNo: connector no on the given charge point
 * contractId : Contract Id that makes use of the chargepoint (only provided if the subscriber is authenticated and has access to the card)
 * event: 
	* timestamp (ISO 8601)

The event type will be extended into these child objects, with their additional properties listed

| SessionStarted | SessionEnded | ChargingStarted | ChargingStopped  | ChargingInterrupted | ChargingInfoUpdated |
|--------------|---------------|--------------|-------------|---------------------|--------------------|
| startDateTime | endDateTime |startDateTime | endDateTime | endDateTime  | kWh |  
||| chargeSessionId | chargeSessionId | chargeSessionId | chargeSessionId

**Privacy note** The party publishing events should be aware that the contractId is linked to person and it's of importance to provide this field **only** to parties that are allowed to make use of that information. 

The operator will publish messages to the provider, the provider will return an OK to indicate that the message is accepted. When there is no OK returned, the operator will try it again until the operator sees no need in resending due to information irrelevancy 


## Unsubscribe
### request
Unsubscribe with the token id received during subscription, plus a list of chargepoints that you no longer wish to receive updates for. Without a list of charge points, all notifications subscribed by this endpoint are stopped.

### response
An OK or error response

## SubscriptionStatus
### request
Retrieve all chargepoints that the given token id is subscribed for.

### response
List of chargepointIdentifiers or an error response


## Message format
The current structure of the interoperable interfaces is based on SOAP/XML. 

## Future options
As a next step, the NDR callback interface can provide CDR information at an EndSession call. 
This CDR information can include pricing information. 

Additionally, the mobi.europe model for chargepoint authentication and authorization can be included.
