# _CDRs_ Business Object

A **Charge Detail Record** is the description of a concluded charging
session. The CDR is the only billing-relevant object.



## 1. Inheritances

*List all inheritors.*

### 1.1 Operator Inheritor

*Describe the purpose and singularity of this inheritor.*

### 1.2 Provider Inheritor

*Describe the purpose and singularity of this inheritor.*



## 2. Flow and Lifecycle

*Describe the status of the objects, how it is created and destroyed,
when and through which action it gets inherited. Name the owner. Explain
the purpose.*




## 3. Interfaces and endpoints

*Explain which interfaces are available and which party should implement
which one.*


### 3.1 Operator Interface

The CDRs endpoint can be used to create or retrieve CDRs.

Endpoint structure `/ocpi/cpo/cdrs/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | Receive all CDRs for the requesting provider.        |
| POST     | n/a                                                  |
| PUT      | n/a                                                  |
| PATCH    | n/a                                                  |
| DELETE   | n/a                                                  |


#### 3.1.1 GET Method

Retrieves all CDRs.

The request should be encoded as `application/x-www-form-urlencoded`.
The parameters are TBD.

The response should be a list of CDRs matching the query parameters.



### 3.2 Provider Interface

The CDRs endpoint can be used to create or retrieve CDRs.

Endpoint structure `/ocpi/msp/cdrs/` and `/ocpi/msp/cdrs/{cdr-id}/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | n/a                                                  |
| POST     | Create a new CDR.                                    |
| PUT      | Correct the CDR.                                     |
| PATCH    | n/a                                                  |
| DELETE   | Invalidate the CDR.                                  |


#### 3.2.1 POST Method

Creates a new CDR.

The request should contain the full, final CDR object.

The response should contain the CDR object with the fields `id`,
`status` and `endpoints` correctly filled.


#### 3.2.2 PUT Method

Corrects the CDR by sending a new one, thus invalidating the old one.

The request should contain the new correct CDR object.

The response should contain the new correct CDR object, with fields `id`, `status` and `endpoints` filled correctly.


#### 3.2.3 DELETE Method

Sending a DELETE method will invalidate a CDR.

The response should contain the CDR object with the status INVALID.



## 4. Object description

*Describe the structure of this object.*

### 4.1 Primary Object

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |


### 4.2 Inheritor Object #1

*If different from the primary object*

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |




## 5. Data types

*Describe all datatypes used in this object*

### 5.X Object Template

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |


### 5.X Enum Template

| Value     | Description                                          |
| --------- | ---------------------------------------------------- |
|           |                                                      |
|           |                                                      |

