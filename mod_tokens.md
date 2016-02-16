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
This method is not for operational flow.


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

If the eMSP wants to check the status of a Token in the CPO system it might GET the object from the CPO system for validation purposes. The eMSP is the owner of the objects, so it would be illogical if the CPO system had a different status of was missing an object.


##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter         | Datatype                              | Required | Description                                                                   |
|-------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code      | [string](types.md#16-string-type)(2)  | yes      | Country code of the CPO requesting this PUT to the eMSP system.               |
| party_id          | [string](types.md#16-string-type)(3)  | yes      | Party ID (Provider ID) of the CPO requesting this PUT to the eMSP system.     |
| token_uid         | [string](types.md#16-string-type)(15) | yes      | Token.uid of the Token object to retrieve.                                    |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The response contains the requested object. 

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                                | Card. | Description                                                |
|-------------------------------------|-------|------------------------------------------------------------|
| [Token](#31-token-object)           | 1     | The requested Token object.                                |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.1.2 __PUT__ Method

New or updated Token objects are pushed from the CPO to the eMSP. 

##### Request Body

In the put request a the new or updated Token object is send.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Token](#31-token-object)       | 1     | New or updated Tariff object.            |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter         | Datatype                              | Required | Description                                                                   |
|-------------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| country_code      | [string](types.md#16-string-type)(2)  | yes      | Country code of the CPO requesting this PUT to the eMSP system.               |
| party_id          | [string](types.md#16-string-type)(3)  | yes      | Party ID (Provider ID) of the CPO requesting this PUT to the eMSP system.     |
| token_uid         | [string](types.md#16-string-type)(15) | yes      | Token.uid of the (new) Token object (to replace).                             |
<div><!-- ---------------------------------------------------------------------------- --></div>

##### Example: put a new Token

```json
PUT To URL: https://www.server.com/ocpi/cpo/2.0/tokens/NL/TNM/012345678

{
  "uid": "012345678",
  "type": "RFID",
  "auth_id": "FA54320",
  "visual_number": "DF000-2001-8999",
  "issuer": "TheNewMotion",
  "valid": true,
  "allow_whitelist": true
}
```


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

This interface enables the CPO to request the current list of all Tokens, when needed.
It is not possible to validate/request a single token, during normal operation the Token cache of the CPO should always
be kept up to date via the CPO Interface.

Example endpoint structure: `/ocpi/emsp/2.0/tokens/`


<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                 | Description                                                             |
|------------------------|-------------------------------------------------------------------------|
| [GET](#221-get-method) | Get the list of known Tokens ([paginated](transport_and_format.md#get)) |
| POST                   | n/a                                                                     |
| PUT                    | n/a                                                                     |
| PATCH                  | n/a                                                                     |
| DELETE                 | n/a                                                                     |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.1 __GET__ Method

Fetch information about all Tokens known in the eMSP systems.

##### Request Parameters

This request is [paginated](transport_and_format.md#get), it supports the [pagination](transport_and_format.md#paginated-request) related URL parameters.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter  | Datatype                              | Required | Description                                                                   |
|------------|---------------------------------------|----------|-------------------------------------------------------------------------------|
| offset     | int                                   | no       | The offset of the first object returned. Default is 0.                        |
| limit      | int                                   | no       | Maximum number of objects to GET.                                             |
<div><!-- ---------------------------------------------------------------------------- --></div>


##### Response Data

The endpoint response with list of valid Token objects, the header will contain the [pagination](transport_and_format.md#paginated-response) related headers. 

Any older information that is not specified in the response is considered as no longer valid.
Each object must contain all required fields. Fields that are not specified may be considered as null values.


<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Token](#31-token-object)       | *     | List of all tokens.                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


## 3. Object description

### 3.1 _Token_ Object

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property                | Type                                  | Card. | Description                                                                                             |
|-------------------------|---------------------------------------|-------|---------------------------------------------------------------------------------------------------------|
| uid                     | [string](types.md#16-string-type)(15) | 1     | Identification used by CPO system to identify this token, for example RFID hidden ID                    |
| type                    | [TokenType](#41-tokentype)            | 1     | Type of the token                                                                                       |
| auth_id                 | [string](types.md#16-string-type)(32) | 1     | Uniquely identifies the EV Driver contract token within the eMSPs platform (and suboperator platforms). Recommended to follow the specification for eMA ID from "eMI3 standard version V1.0" (http://emi3group.com/documents-links/) "Part 2: business objects." |
| visual_number           | [string](types.md#16-string-type)(64) | 1     | Visual readable number/identification of the Token                                                      |
| issuer                  | [string](types.md#16-string-type)(64) | 1     | Issuing company                                                                                         |
| valid                   | boolean                               | 1     | Is this Token valid                                                                                     |
| allow_whitelist         | boolean                               | ?     | It is allowed to validate a charging session with token without requesting and authorization from the eMSP? , default is FALSE. NOTE: For this release this field always needs to be set to TRUE |
<div><!-- ---------------------------------------------------------------------------- --></div>

The combination of _uid_ and _type_ should be unique for every token.


#### Example

```json
{
  "uid": "012345678",
  "type": "RFID",
  "auth_id": "FA54320",
  "visual_number": "DF000-2001-8999",
  "issuer": "TheNewMotion",
  "valid": true,
  "allow_whitelist": true
}
```


## 4. Data types

### 4.1 TokenType *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| OTHER        | Other type of token                                  |
| RFID         | RFID Token                                           |
<div><!-- ---------------------------------------------------------------------------- --></div>
