# _Tokens_ module

**Identifier: tokens**

The tokens module gives CPOs knowledge of the token information of an eMSP.
eMSPs can push Token information to CPOs, CPOs can build a cache of known Tokens.
When a request to authorize comes from a Charge Point, the CPO can check against this cache. 
They then know to which eMSP they can later send a CDR. 


## 1. Inheritances

N/A

## 2. Flow and Lifecycle

*Describe the status of the objects, how it is created and destroyed,
when and through which action it gets inherited. Name the owner. Explain
the purpose.*




## 3. Interfaces and endpoints

There is both a CPO and an eMSP interface for Tokens. Advised is to use the push direction from eMSP to CPO during normal operation.
The eMSP interface is mend to be used when the CPO is not 100% sure the Token cache is correct anymore.


### 3.1 CPO Interface

With this interface the eMSP can push the full list of tokens, or push an update with updated Tokens to the CPO.

Example endpoint structure: `/ocpi/cpo/2.0/tokens/`

| Method   | Description                                                |
| -------- | ---------------------------------------------------------- |
| GET      | n/a                                                        |
| POST     | Resend the full list of tokens, replace the current cache. |
| PUT      | Send a list of tokens to update existing tokens            |
| PATCH    | n/a                                                        |
| DELETE   | n/a (Use PUT, Tokens cannot be removed                     |


### 3.1 eMSP Interface

This interface enables the CPO to request the current list of all Tokens, when needed.
It is not possible to validate/request a single token, during normal operation the Token cache of the CPO should always
be kept up to date via the CPO Interface.

Example endpoint structure: `/ocpi/emsp/2.0/tokens/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | Get the full list of known Tokens                    |
| POST     | n/a                                                  |
| PUT      | n/a                                                  |
| PATCH    | n/a                                                  |
| DELETE   | n/a                                                  |


## 4. Object description

*Describe the structure of this object.*

### 4.1 Token

| Property        | Type          | Card. | Description                                                                           |
|-----------------|---------------|-------|---------------------------------------------------------------------------------------|
| uid             | string(15)    | 1     | Identification used by CPO system to identify this token, for example RFID hidden ID  |
| type            | [TokenType](#5-1-tokentype) | 1     | Type of the token                                                                     |
| auth_id         | string(32)    | 1     | Uniquely identifies the EV Driver contract token within the eMSPs platform (and suboperator platforms).  |
| visual_number   | string(64)    | 1     | Visual readable number/identification of the Token                                    |
| issuer          | string(64)    | 1     | Issuing company                                                                       |
| allow_whitelist | boolean       | ?     | It is allowed to whitelist this Token, default is false                                               |

The combination of _uid_ and _type_ should be unique for every token.


## 5. Data types

### 5.1 TokenType

| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| Other        | Other type of token                                  |
| RFID         | RFID Token                                           |

