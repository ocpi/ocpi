# _Tokens_ module

**Module Identifier: tokens**

The tokens module gives CPOs knowledge of the token information of an eMSP.
eMSPs can push Token information to CPOs, CPOs can build a cache of known Tokens.
When a request to authorize comes from a Charge Point, the CPO can check against this cache. 
They then know to which eMSP they can later send a CDR. 


## 1. Inheritances

N/A


## 2. Flow and Lifecycle

### 2.1 Push model

When the MSP creates Tokens(s) they push them to the CPO by calling [POST](#311-post-method) on the CPOs
Tokens endpoint with the newly create Token(s)

Any changes to Token(s) in the eMSP system are send to the CPO system by calling [PUT](#312-put-method)
on the CPOs Tokens endpoint with the updated Token(s).

When the eMSP invalidates a Token (deleting is not possible), 
the eMSP will send the updated Token (with the field: valid set to False, by calling the [PUT](#312-put-method)
on the CPOs Tokens endpoint with the updated Token. 


### 2.2 (Re)loading full list of Tokens

When a CPO is not sure about the state of the list of known Tokens, or wants to request the full 
list at startup of there system, the CPO can call the [GET](#321-get-method) on the eMSPs Token endpoint to receive
all Tokens, updating already known Tokens and adding new received Tokens to it own list of Tokens.
This method is not for operational flow.


## 3. Interfaces and endpoints

There is both a CPO and an eMSP interface for Tokens. Advised is to use the push direction from eMSP to CPO during normal operation.
The eMSP interface is mend to be used when the CPO is not 100% sure the Token cache is correct anymore.


### 3.1 CPO Interface

With this interface the eMSP can push the full list of tokens, or push an update with updated Tokens to the CPO.

Example endpoint structure: `/ocpi/cpo/2.0/tokens/`

| Method                       | Description                                                |
|------------------------------|------------------------------------------------------------|
| GET                          | n/a                                                        |
| [POST](#311-post-method)     | Resend the full list of tokens, replace the current cache. |
| [PUT](#312-put-method)       | Send a list of tokens to update existing tokens            |
| PATCH                        | n/a                                                        |
| [DELETE](#313-delete-method) | n/a (Use PUT, Tokens cannot be removed)                    |


#### 3.1.1 __POST__ Method

New created Token Objects are pushed from the eMSP to the CPO. 

##### Data

In the post request a list of new Token Objects is send.

| Type                      | Card. | Description                              |
|---------------------------|-------|------------------------------------------|
| [Token](#41-token-object) | *     | List of all tokens.                      |


#### 3.1.2 __PUT__ Method

Updated Token Objects are pushed from the eMSP to the CPO. 

##### Data

In the put request a list of updated Token objects is send.

| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Token](#41-token-object)       | *     | List of all tokens.                      |


#### 3.1.3 __DELETE__ Method

DeleteUpdated Token Objects are pushed from the eMSP to the CPO. 

##### Parameters

| Parameter  | Datatype                              | Required | Description                               |
|------------|---------------------------------------|----------|-------------------------------------------|
| token_id   | [string](types.md#16-string-type)(15) | yes      | ID of the Token to be deleted             |


### 3.2 eMSP Interface

This interface enables the CPO to request the current list of all Tokens, when needed.
It is not possible to validate/request a single token, during normal operation the Token cache of the CPO should always
be kept up to date via the CPO Interface.

Example endpoint structure: `/ocpi/emsp/2.0/tokens/`

| Method                 | Description                                          |
|------------------------|----------------------------------------------------- |
| [GET](#321-get-method) | Get the full list of known Tokens                    |
| POST                   | n/a                                                  |
| PUT                    | n/a                                                  |
| PATCH                  | n/a                                                  |
| DELETE                 | n/a                                                  |


#### 3.2.1 __GET__ Method

Fetch information about all Tokens known in the eMSP systems.


##### Data

The endpoint response with list of valid Token objects.

| Type                            | Card. | Description                              |
|---------------------------------|-------|------------------------------------------|
| [Token](#41-token-object)       | *     | List of all tokens.                      |



## 4. Object description

### 4.1 Token

| Property        | Type                                  | Card. | Description                                                                                             |
|-----------------|---------------------------------------|-------|---------------------------------------------------------------------------------------------------------|
| uid             | [string](types.md#16-string-type)(15) | 1     | Identification used by CPO system to identify this token, for example RFID hidden ID                    |
| type            | [TokenType](#5-1-tokentype)           | 1     | Type of the token                                                                                       |
| auth_id         | [string](types.md#16-string-type)(32) | 1     | Uniquely identifies the EV Driver contract token within the eMSPs platform (and suboperator platforms). |
| visual_number   | [string](types.md#16-string-type)(64) | 1     | Visual readable number/identification of the Token                                                      |
| issuer          | [string](types.md#16-string-type)(64) | 1     | Issuing company                                                                                         |
| valid           | boolean                               | 1     | Is this Token valid                                                                                     |
| allow_whitelist | boolean                               | ?     | It is allowed to validate a charging session with token without requesting and authorization from the eMSP? , default is FALSE. NOTE: For this release this field always needs to be set to TRUE |

The combination of _uid_ and _type_ should be unique for every token.


#### Example

```
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


## 5. Data types

### 5.1 TokenType *enum*

| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| Other        | Other type of token                                  |
| RFID         | RFID Token                                           |

