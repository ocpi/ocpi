# _Commands_ module

**Module Identifier: `commands`**

The Commands module enables remote commands to be send to an Location/EVSE.


## 1. Flow

TODO Describe asynchronous nature of this interface/module
 

## 2. Interfaces and endpoints

TODO

### 2.1 CPO Interface

Example endpoint structure: `/ocpi/cpo/2.0/commands/{command}`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                   | Description                                          |
|--------------------------| -----------------------------------------------------|
| GET                      | n/a                                                  |
| [POST](#211-post-method) | Send a command to the CPO, requesting the CPO to send the command to the Charge Point |
| PUT                      | n/a                                                  |
| PATCH                    | n/a                                                  |
| DELETE                   | n/a                                                  |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.1.1 __POST__ Method

##### Request Parameters

The following parameters can be provided as URL segments.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Parameter   | Datatype                          | Required | Description                                                                   |
|-------------|-----------------------------------|----------|-------------------------------------------------------------------------------|
| command     | [CommandType](#4xx-command-enum)  | yes      | TODO                                                                          |
<div><!-- ---------------------------------------------------------------------------- --></div>

#### Request Body

Depending on the `command` parameter the body SHALL contain the applicable object for that command. 

<div><!-- ---------------------------------------------------------------------------- --></div>
| Type                                            | Card. | Description                                            |
|-------------------------------------------------|-------|--------------------------------------------------------|
| *Choice: one of four*                           |       |                                                        |
| > [ReserveNow](#3x-reservenow-object)           | 1     | ReserveNow object, for the `RESERVE_NOW` command, with information needed to reserve a (specific) connector of a Charge Point for a given Token. |
| > [StartSession](#3x-startsession-object)       | 1     | StartSession object, for the `START_SESSION` command, with information needed to start a sessions.                                               |
| > [StopSession](#3x-stopsession-object)         | 1     | StopSession object, for the `STOP_SESSION` command, with information needed to stop a sessions.                                                  |
| > [UnlockConnector](#31-unlockconnector-object) | 1     | UnlockConnector object, for the `UNLOCK_CONNECTOR` command, with information needed to unlock a connector of a Charge Point.                     |
<div><!-- ---------------------------------------------------------------------------- --></div>



### 2.2 eMSP Interface

The eMSP interface receives the asynchronous responses.

Example endpoint structure: `/ocpi/emsp/2.0/commands/{command}`

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method                   | Description                                          |
|--------------------------| -----------------------------------------------------|
| GET                      | n/a                                                  |
| [POST](#221-post-method) | Receive the response from the Charge Point           |
| PUT                      | n/a                                                  |
| PATCH                    | n/a                                                  |
| DELETE                   | n/a                                                  |
<div><!-- ---------------------------------------------------------------------------- --></div>


#### 2.2.1 __POST__ Method

TODO


##### Request Parameters

TODO


##### Response Data

TODO




## 3. Object description

TODO


### 3.1 xx Object

TODO 



## 4. Data types

### 4.1 xx *class*


### 4.XX CommandType *enum*

The command requested.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Value                 | Description |
|-----------------------|-------------------------------------------------------------------|
| RESERVE_NOW           | Request the Charge Point to request a (specific) connector for a Token for a certain time.                           |
| START_SESSION         | Request the Charge Point to start a transaction on the given EVSE/Connector.                                         |
| STOP_SESSION          | Request the Charge Point to stop a ongoing session.                                                                  |
| UNLOCK_CONNECTOR      | Request the Charge Point to unlock the connector (if applicable) this functionality is for help desk operators only! |
<div><!-- ---------------------------------------------------------------------------- --></div>

**The command `UNLOCK_CONNECTOR` may only be used by an operator of the eMSP. This command SHALL never be allowed to be send directly by the EV-Driver. 
The `UNLOCK_CONNECTOR` is intended to be used in the rare situation that the connector is not unlock successfully after a transaction is stopped. The mechanical unlock of the lock mechanism might, for example fail when there is tension on the charging cable when the Charge Point tries to unlock the connector.
In such a situation the EV-Driver can call either the CPO or the eMSP to retry the unlocking.** 