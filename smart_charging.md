## Smart charging

**TO BE DEFINED**

In order to have this functionality working is required the chapter about Session information exchange has been read and implemented.

### RequestChargingProfile

#### request
message contains:
 
 * evse_id: Unique identifier of the EVSE that is attached to the session of the user
 * List of [start_datetime + max_power (in watts)]
 * tariff_type (specified in the  CDR  format, it is a string of 2 characters)

The EVSE is part of the message to specify the controller in use by this user. The unique EVSE number is given via the NDR interface the moment a session starts. As long as the session is active, the EVSE id is connected to Contract ID using the charge point. 

As it is possible to set up a charging schedule, a list of start date time and the requested maxPower in watts is expected. The charge point will behave as specified based on it's own current time and the part of the specified list is 'active'. 
It is expected to have non-overlapping start date times. Absolute date times in the ISO8601 format are expected to prevent the wrong interpretation of time relative to receiving these messages. 

max_power is specified in **watts**, to be compatible with the OCPP spec. 

**TODO: OCPP allows for the use of Amperage, smart charging group is to decide the final format**

tariff_type is a chosen string of 2 characters. The string is free and the specification is currently agreed upon between operator and provider.

**expected behaviour**

A charge point will always start charging in its default mode without waiting for this message as it is not said that this message will be sent / received. Local Load Balancing may be applied according to the operator needs and will be notified via the NDR messages.

The RequestChargingProfile message may be sent more than a single time. When a change is applied by the operator, a new section in the chargesession will be registered for billing. (see the CDR format for more information)

#### response

Response is an OK that it is received as expected. Actual acceptance / denial is provided via the NDR callback interface. The operator will send a ChargingProfileAccepted, ChargingProfileFailed or ChargingProfileDenied. These are explained in the NDR interface chapter.  

### Provider implemented interfaces

Notifications: NDR callback interface

This interface is implemented at the receiver side (the one that called the OCPI interface with a subscribe needs to implement this interface for receiving the NDR calls)

Please note that many different circumstances may allow the operator to select different timings to provide these messages. It should be taken into account, that the primary goal of the interface is to inform the driver. Moments to publish the information should help the understanding of the driver of what is happening. 

This interface will receive:

 * operator : code of the operator
 * subscription_id : subscription id that matches the one returned in the subscribe response
 * evse_id: unique identifier of the EVSE inside the charge point
 * connector_no: connector no on the given charge point
 * contract_id : Contract ID that makes use of the charge point (be aware of privacy issues)
 * event_type: specific event types are found in the table below. 
 * event_payload : Json object with the actual payload
* timestamp (ISO 8601)

The event type will be extended into these child objects, with their additional properties listed

#### Event Types informing about profiles application

##### ChargingProfileAccepted

ChargingProfileAccepted indicates that the Requested Charging Profile is accepted and applied by the operator.

##### ChargingProfileDenied

ChargingProfileDenied indicates that the Requested Charging Profile is denied and will not be applied by the operator.

##### ChargingProfileFailed

ChargingProfileFailed indicates that the Requested Charging Profile could not be applied by the operator.
