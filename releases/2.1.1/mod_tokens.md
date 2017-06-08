# _Tokens_ module

**Module Identifier: `tokens`**

The tokens module gives CPOs knowledge of the token information of an eMSP.
eMSPs can push Token information to CPOs, CPOs can build a cache of known Tokens.
When a request to authorize comes from a Charge Point, the CPO can check against this cache. 
With this cached information they know to which eMSP they can later send a CDR. 


## 1. Flow and Lifecycle

### 1.1 Push model

When the MSP creates a new Token object they push it to the CPO by calling [PUT](#212-put-method) on the CPOs Tokens endpoint with the newly created Token object.

Any changes to Token in the eMSP system are send to the CPO system by calling, either the [PUT](#212-put-method) or the [PATCH](#213-patch-method) on the CPOs Tokens endpoint with the updated Token(s).

When the eMSP invalidates a Token (deleting is not possible), the eMSP will send the updated Token (with the field: valid set to False, by calling, either the [PUT](#212-put-method) or the [PATCH](#213-patch-method) on the CPOs Tokens endpoint with the updated Token. 

When the eMSP is not sure about the state or existence of a Token object in the CPO system, the 
eMSP can call the [GET](#221-get-method) to validate the Token object in the CPO system.   


### 1.2 Pull model

When a CPO is not sure about the state of the list of known Tokens, or wants to request the full 
list as a start-up of their system, the CPO can call the [GET](#221-get-method) on the eMSPs Token endpoint to receive
all Tokens, updating already known Tokens and adding new received Tokens to it own list of Tokens.
This is not intended for real-time operation, requesting the full list of tokens for every authorization will put to much strain on systems. 
It is intended for getting in-sync with the server, or to get a list of all tokens (from a server without push) every X hours.


### 1.3 Real-time authorization

An eMSP might want their Tokens to be authorization 'real-time', not white-listed. For this the eMSP has to implement the [POST Authorize request](#222-post-method) and set the Token.whitelist field to `NEVER` for Tokens they want to have authorized 'real-time'.

If an eMSP doesn't want real-time authorization, the [POST Authorize request](#222-post-method) doesn't have to be implemented as long as all their Tokens have Token.whitelist set to `ALWAYS`.  


## 2. Interfaces and endpoints

There is both a CPO and an eMSP interface for Tokens. It is advised to use the push direction from eMSP to CPO during normal operation.
The eMSP interface is meant to be used when the CPO is not 100% sure the Token cache is still correct.


### 2.1 CPO Interface

With this interface the eMSP can push the Token information to the CPO.
Tokens is a [client owned object](transport_and_format.md#client-owned-object-push), so the end-points need to contain the required extra fields: {[party_id](credentials.md#credentials-object)} and {[country_code](credentials.md#credentials-object)}.
Example endpoint structure: 
`/ocpi/cpo/2.0/tokens/{country_code}/{party_id}/{token_uid}` 

<div><!-- ---------------------------------------------------------------------------- --></div>

| Method                       | Description                                                  |
|------------------------------|--------------------------------------------------------------|
| [GET](#211-post-method)      | Retrieve a Token as it is stored in the CPO system.          |
| POST                         | n/a                                                          |
| [PUT](#212-put-method)       | Push new/updated Token object to the CPO.                    |
| [PATCH](#213-put-method)     | Notify the CPO of partial updates to a Token.                |
| DELETE                       | n/a, (Use [PUT](#212-put-method), Tokens cannot be removed). |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.1.1 __GET__ Method

If the eMSP wants to check the status of a Token in the CPO system it might GET the object from the CPO system for validation purposes. The eMSP is the owner of the objects, so it would be illogical if the CPO system had a different status or was missing an object.


##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter         | Datatype                              | Required | Description                                                                   |
|-------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code      | [string](types.md#15-string-type)(2)  | yes      | Country code of the eMSP requesting this GET from the CPO system.             |
| party_id          | [string](types.md#15-string-type)(3)  | yes      | Party ID (Provider ID) of the eMSP requesting this GET from the CPO system.   |
| token_uid         | [string](types.md#15-string-type)(36) | yes      | Token.uid of the Token object to retrieve.                                    |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The response contains the requested object. 

<div><!-- ---------------------------------------------------------------------------- --></div>

| Type                                | Card. | Description                                                |
|-------------------------------------|-------|------------------------------------------------------------|
| [Token](#32-token-object)           | 1     | The requested Token object.                                |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.1.2 __PUT__ Method

New or updated Token objects are pushed from the eMSP to the CPO. 

##### Request Body

In the put request a the new or updated Token object is send.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Token](#32-token-object)       | 1     | New or updated Token object.             |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter         | Datatype                              | Required | Description                                                                   |
|-------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code      | [string](types.md#15-string-type)(2)  | yes      | Country code of the eMSP sending this PUT request to the CPO system.               |
| party_id          | [string](types.md#15-string-type)(3)  | yes      | Party ID (Provider ID) of the eMSP sending this PUT request to the CPO system.     |
| token_uid         | [string](types.md#15-string-type)(36) | yes      | Token.uid of the (new) Token object (to replace).                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

##### Example: put a new Token

```json
PUT To URL: https://www.server.com/ocpi/cpo/2.0/tokens/NL/TNM/012345678

{
  "uid": "012345678",
  "type": "RFID",
  "auth_id": "DE8ACC12E46L89",
  "visual_number": "DF000-2001-8999",
  "issuer": "TheNewMotion",
  "valid": true,
  "whitelist": "ALWAYS",
  "last_updated": "2015-06-29T22:39:09Z"
}
```


<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

#### 2.1.2 __PATCH__ Method

Same as the [PUT](#212-put-method) method, but only the fields/objects that have to be updated have to be present, other fields/objects that are not specified are considered unchanged.

##### Example: invalidate a Token

```json
PATCH To URL: https://www.server.com/ocpi/cpo/2.0/tokens/NL/TNM/012345678

{
  "valid": false
}
```


### 2.2 eMSP Interface

This interface enables the CPO to request the current list of Tokens, when needed.
Via the POST method it is possible to authorize a single token.

Example endpoint structure: `/ocpi/emsp/2.0/tokens/?date_from=xxx&date_to=yyy`


<div><!-- ---------------------------------------------------------------------------- --></div>

| Method                   | Description                                                             |
|--------------------------|-------------------------------------------------------------------------|
| [GET](#221-get-method)   | Get the list of known Tokens, last updated between the {date_from} and {date_to} ([paginated](transport_and_format.md#get)) |
| [POST](#222-post-method) | Real-time authorization request                                         |
| PUT                      | n/a                                                                     |
| PATCH                    | n/a                                                                     |
| DELETE                   | n/a                                                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.1 __GET__ Method

Fetch information about Tokens known in the eMSP systems.

##### Request Parameters

If additional parameters: {date_from} and/or {date_to} are provided, only Tokens with (`last_updated`) between the given date_from and date_to will be returned.

This request is [paginated](transport_and_format.md#get), it supports the [pagination](transport_and_format.md#paginated-request) related URL parameters.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter     | Datatype                              | Required | Description                                                                   |
|---------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| date_from     | [DateTime](types.md#12-datetime-type) | no       | Only return Tokens that have `last_updated` after this Date/Time.             |
| date_to       | [DateTime](types.md#12-datetime-type) | no       | Only return Tokens that have `last_updated` before this Date/Time.            |
| offset        | int                                   | no       | The offset of the first object returned. Default is 0.                        |
| limit         | int                                   | no       | Maximum number of objects to GET.                                             |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The endpoint response with list of valid Token objects, the header will contain the [pagination](transport_and_format.md#paginated-response) related headers. 

Any older information that is not specified in the response is considered as no longer valid.
Each object must contain all required fields. Fields that are not specified may be considered as null values.


<div><!-- ---------------------------------------------------------------------------- --></div>

| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Token](#32-token-object)       | *     | List of all tokens.                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.2 __POST__ Method

Do a 'real-time' authorization request to the eMSP system, validating if a Token might be used (at the optionally given Location). 

Example endpoint structure: 
`/ocpi/emsp/2.0/tokens/{token_uid}/authorize?{type=token_type}`
The `/authorize` is required for the real-time authorize request.

When the eMSP receives a 'real-time' authorization request from a CPO that contains too little information (no LocationReferences provided) to determine if the Token might be used, the eMSP SHOULD respond with the OCPI status: [2002](status_codes.md#2xxx-client-errors) 

##### Request Parameters

The following parameter has to be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter         | Datatype                              | Required | Description                                               |
|-------------------|---------------------------------------|----------|-----------------------------------------------------------|
| token_uid         | [string](types.md#15-string-type)(36) | yes      | Token.uid of the Token for which this authorization is.   |
| token_type        | [TokenType](#43-tokentype-enum)       | no       | Token.type of the Token for which this authorization is. Default if omitted: [RFID](#43-tokentype-enum) |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Request Body

In the body an optional [LocationReferences](#42-locationreferences-class) object can be given. The eMSP SHALL then validate if the Token is allowed to be used at this Location, and if applicable: which of the Locations EVSEs/Connectors.
The object with valid Location and EVSEs/Connectors will be returned in the response.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Type                                                | Card. | Description                                                                     |
|-----------------------------------------------------|-------|---------------------------------------------------------------------------------|
| [LocationReferences](#42-locationreferences-class)  | ?     | Location and EVSEs/Connectos for which the Token is requested to be authorized. |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The endpoint response contains a [AuthorizationInfo](#31-authorizationinfo-object) object.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Type                                              | Card. | Description                              |
|---------------------------------------------------|-------|------------------------------------------|
| [AuthorizationInfo](#31-authorizationinfo-object) | 1     | Contains information about the authorization, if the Token is allowed to charge and optionally which EVSEs/Connectors are allowed to be used. |
<div><!-- ---------------------------------------------------------------------------- --></div>


## 3. Object description

### 3.1 _AuthorizationInfo_ Object

<div><!-- ---------------------------------------------------------------------------- --></div>

| Property  | Type                                               | Card. | Description                                                                           |
|-----------|----------------------------------------------------|-------|---------------------------------------------------------------------------------------|
| allowed   | [Allowed](#41-allowed-enum)                        | 1     | Status of the Token, and if it is allowed to charge at the optionally given location. |
| location  | [LocationReferences](#42-locationreferences-class) | ?     | Optional reference to the location if it was request in the request, and if the EV driver is allowed to charge at that location. Only the EVSEs/Connectors the EV driver is allowed to charge at are returned.                                                                     |
| info      | [DisplayText](types.md#13-displaytext-class)       | ?     | Optional display text, additional information to the EV driver.                       |
<div><!-- ---------------------------------------------------------------------------- --></div>


<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

### 3.2 _Token_ Object

<div><!-- ---------------------------------------------------------------------------- --></div>

| Property                | Type                                  | Card. | Description                                                                                             |
|-------------------------|---------------------------------------|-------|---------------------------------------------------------------------------------------------------------|
| uid                     | [string](types.md#15-string-type)(36) | 1     | Identification used by CPO system to identify this token. Currently, in most cases, this is the RFID hidden ID as read by the RFID reader. |
| type                    | [TokenType](#43-tokentype-enum)       | 1     | Type of the token                                                                                       |
| auth_id                 | [string](types.md#15-string-type)(36) | 1     | Uniquely identifies the EV Driver contract token within the eMSPs platform (and suboperator platforms). Recommended to follow the specification for eMA ID from "eMI3 standard version V1.0" (http://emi3group.com/documents-links/) "Part 2: business objects." |
| visual_number           | [string](types.md#15-string-type)(64) | ?     | Visual readable number/identification as printed on the Token (RFID card), might be equal to the auth_id. |
| issuer                  | [string](types.md#15-string-type)(64) | 1     | Issuing company, most of the times the name of the company printed on the token (RFID card), not necessarily the eMSP. |
| valid                   | boolean                               | 1     | Is this Token valid                                                                                     |
| whitelist               | [WhitelistType](#44-whitelisttype-enum) | 1     | Indicates what type of white-listing is allowed.                                                      |
| language                | [string](types.md#15-string-type)(2)  | ?     | Language Code ISO 639-1. This optional field indicates the Token owner's preferred interface language. If the language is not provided or not supported then the CPO is free to choose its own language.      |
| last_updated            | [DateTime](types.md#12-datetime-type) | 1     | Timestamp when this Token was last updated (or created).                                                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

The combination of _uid_ and _type_ should be unique for every token within an eMSPs system.


#### Example

```json
{
  "uid": "012345678",
  "type": "RFID",
  "auth_id": "DE8ACC12E46L89",
  "visual_number": "DF000-2001-8999",
  "issuer": "TheNewMotion",
  "valid": true,
  "whitelist": "ALLOWED",
  "last_updated": "2015-06-29T22:39:09Z"
}
```


## 4. Data types

### 4.1 Allowed *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>

| Value            | Description                                                                                   |
|------------------|-----------------------------------------------------------------------------------------------|
| ALLOWED          | This Token is allowed to charge at this location.                                             |
| BLOCKED          | This Token is blocked.                                                                        |
| EXPIRED          | This Token has expired.                                                                       |
| NO_CREDIT        | This Token belongs to an account that has not enough credits to charge at the given location. |
| NOT_ALLOWED      | Token is valid, but is not allowed to charge at the given location.                           |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 4.2 LocationReferences *class* 

References to location details.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Field Name       | Field Type                               | Card. | Description                                                         |
|------------------|------------------------------------------|-------|---------------------------------------------------------------------|
| location_id      | [string](types.md#15-string-type)(39)    | 1     | Uniquely identifier for the location.                               |
| evse_uids        | [string](types.md#15-string-type)(39)    | *     | Uniquely identifier for EVSEs within the CPOs platform for the EVSE within the the given location. |
| connector_ids    | [string](types.md#15-string-type)(36)    | *     | Identifies the connectors within the given EVSEs.                   |                                                                                 |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 4.3 TokenType *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>

| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| OTHER        | Other type of token                                  |
| RFID         | RFID Token                                           |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 4.4 WhitelistType *enum*

Defines when authorization of a Token by the CPO is allowed. 

<div><!-- ---------------------------------------------------------------------------- --></div>

| Value                           | Description                                                                |
|---------------------------------|----------------------------------------------------------------------------|
| ALWAYS                          | Token always has to whitelisted, [realtime authorization](mod_tokens.md#13-real-time-authorization) is not possible/allowed. |
| ALLOWED                         | It is allowed to whitelist the token, [realtime authorization](mod_tokens.md#13-real-time-authorization) is also allowed.   |
| ALLOWED_OFFLINE                 | Whitelisting is only allowed when CPO cannot reach the eMSP (communication between CPO and eMSP is offline)                  |
| NEVER                           | Whitelisting is never allowed/forbidden, only [realtime authorization](mod_tokens.md#13-real-time-authorization) allowed. Token should always be authorized by the eMSP. |
<div><!-- ---------------------------------------------------------------------------- --></div>
