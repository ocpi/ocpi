# _Tokens_ Business Object

*General description of the business object*



## 1. Inheritances

*List all inheritors.*

### 1.1 Inheritor #1

*Describe the purpose and singularity of this inheritor.*



## 2. Flow and Lifecycle

*Describe the status of the objects, how it is created and destroyed,
when and through which action it gets inherited. Name the owner. Explain
the purpose.*




## 3. Interfaces and endpoints

*Explain which interfaces are available and which party should implement
which one.*


### 3.1 Interface #1

*Describe the interface in detail.*

Endpoint structure /xxx/yyy/

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      |                                                      |
| POST     |                                                      |
| PUT      |                                                      |
| PATCH    |                                                      |
| DELETE   |                                                      |




## 4. Object description

*Describe the structure of this object.*

### 4.1 Token

| Property        | Type          | Card. | Description                                                                           |
|-----------------|---------------|-------|---------------------------------------------------------------------------------------|
| uid             | string(15)    | 1     | Identification used by CPO system to identify this token, for example RFID hidden ID  |
| type            | TokenType     | 1     | Type of the token                                                                     |
| auth_id         | string(??)    | 1     | Uniquely identifies the token within the eMSPs platform (and suboperator platforms).  |
| visual_number   | string(??)    | 1     | Visual number of the Token                                                            |
| issuer          | string(??)    | 1     | Issuing company                                                                       |
| allow_whitelist | boolean       | 1     | It is allowed to whitelist this Token                                                 |


## 5. Data types

*Describe all datatypes used in this object*

### 5.X TokenType

| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| RFID         | RFID Token                                           |
|              |                                                      |
|              |                                                      |
|              |                                                      |

