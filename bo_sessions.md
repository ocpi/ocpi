# _Sessions_ module

**Module Identifier: sessions**

The session object describes one charging session in a roaming scenario.
The object is virtual and lives between the operator's and provider's
systems. Each of the two parties hold a inheritance of this virtual
object.


## 1. Inheritances

The generic _Session_ object is a virtual object which describes one
charging session in a roaming case. It inherits into two child
objects, the _CPOSession_ object in the operator system and the
_EMSPSession_ in the provider system. The leading instance is the
_CPOSession_ object. The CPO updates the virtual parent _Session_
object. The _EMSPSession_ object inherits the updates.

![The Session Object][session-object]


### 1.1 Operator Inheritor

The operator inheritance of the session object contains charging station
related data.


### 1.2 Provider Inheritor

The provider inheritance of the session object contains user and billing
related data.


## 2. Flow and Lifecycle

The following sequence diagram illustrates the data flow between
operator an provider:

![Session Sequence Diagram][session-sequence-diagram]


## 3. Interfaces and endpoints

*Explain which interfaces are available and which party should implement
which one.*


### 3.1 CPO Interface

*Describe the interface in detail.*

Example endpoint structure: `/ocpi/cpo/2.0/sessions/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | Returns all _CPOSession_ objects for that provider.  |
| POST     | n/a                                                  |
| PUT      | n/a                                                  |
| PATCH    | n/a                                                  |
| DELETE   | n/a                                                  |


### 3.2 eMSP Interface

*Describe the interface in detail.*

Example endpoint structure: `/ocpi/emsp/2.0/sessions/` and
`/ocpi/emsp/2.0/sessions/{session-id}/`

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      | n/a                                                  |
| POST     | Send a new _CPOSession_ object                       |
| PUT      | n/a                                                  |
| PATCH    | Update the _CPOSession_ object of id {session-id}.   |
| DELETE   | Delete the _CPOSession_ object of id {session-id}.   |


#### 3.2.1 __POST__ Method

Create a new session in the eMSP backoffice by POSTing a _CPOSession_
object.

The response contains a _EMSPSession_ object enriched with the
**status** and **endpoints** fields and the **id** field filled.

The endpoints field contains the endpoints relevant to the session that
was created.

##### Example:

```
"endpoints": [
  {"identifier": "uri", "url": "http://msp/sessions/345/"},
  {"identifier": "create_cdr", "url": "http://msp/sessions/345/create_cdr"}
]
```

##### 3.2.2 __PATCH__ Method

Inform about updates in the _Session_ object.

The response will contain the updated _EMSPSession_ object.


## 4. Object description

*Describe the structure of this object.*

### 4.1 _Session_ Object

| Property          | Type              | Card. | Description                                                    |
|-------------------|-------------------|-------|----------------------------------------------------------------|
| id                | string            | 1     | The unique id that identifies the session in the CPO platform. |
| start_datetime    | DateTime          | 1     | The time when the session became active.     |
| end_datetime      | DateTime          | ?     | The time when the session is completed.      |
| kwh               | Decimal           | 1     | How many kWh are charged.                    |
| auth_id           | string            | 1     | An id provided by the authentication mechanism so that the eMSP knows to which driver the session belongs. |
| location          | [Location](bo_locations_and_evses.md#41-location-object) | 1     | The location where this session took place. |
| evse              | [EVSE](bo_locations_and_evses.md#42-evse-object)        | 1     | The EVSE that was used for this session. |
| connector_number  | int               | 1     | Zero-based index of the connector used at the EVSE.  |
| meter_id          | string            | ?     | Optional identification of the kWh meter.            |
| currency          | string            | 1     | ISO 4217 code of the currency used for this session. |
| charging_periods  | [ChargingPeriod](#52-chargingperiod-type) | *     | An optional list of charging periods that can be used to calculate and verify the total cost. |
| total_cost        | Decimal           | 1     | The total cost (excluding VAT) of the session in the specified currency. This is the price that the eMSP will have to pay to the CPO. |
| status            | [SessionStatus](#51-sessionstatus-enum) | 1     | The status of the session. |
| endpoints         | [Endpoint](version_information_endpoint.md#endpoint-class) | *     | Lists the related endpoints to the session. These are specific for each party. See below for more information. |



### 4.2 _CPOSession_ Object

Describes a session in the CPO platform

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
| endpoints | [Endpoint](version_information_endpoint.md#endpoint-class) | * |                                |
|           |             |       |                                |



### 4.3 _EMSPSession_ Object

Describes a session in the eMSP platform

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
| endpoints | [Endpoint](version_information_endpoint.md#endpoint-class) | * |                                |
|           |             |       |                                |





## 5. Data types

*Describe all datatypes used in this object*

### 5.1 SessionStatus *enum*

| Property  | Description                                                                |
|-----------|----------------------------------------------------------------------------|
| PENDING   | The session is pending and has not yet started. This is the initial state. |
| ACTIVE    | The session is accepted and active.                                        |
| COMPLETED | The session has finished succesfully.                                      |
| INVALID   | The session is declared invalid and will not be billed.                    |
| DISPUTED  | The eMSP disputes the validity of the session. This status will have to be resolved manually. |

### 5.2 ChargingPeriod *type*

| Property  | Type        | Card. | Description                              |
|-----------|-------------|-------|------------------------------------------|
| start_datetime       | DateTime       | 1     |  |
| end_datetime         | DateTime       | 1     |  |
| tariff_number        | string         | 1     |  |
| kwh                  | int            | 1     |  |
| cost                 | string         | 1     |  |
| max_power            | int            | 1     |  |

### Object Template

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |


### Enum Template

| Value     | Description                                          |
| --------- | ---------------------------------------------------- |
|           |                                                      |
|           |                                                      |


---







## Appendix: Figures

### Session Object

![The Session Object][session-object]
[session-object]: http://plantuml.com/plantuml/svg/hL9DJyCm3BttLrZYrh7jpiS1iI5n02QAk20qfQcx1NL95Rj2QEo_usRjbe4cBdEboebV_LwVdI6HSHQkleT3k9qzPTjpaiNtquTirXT07fKJUwKPTAM8eCUk4v1uDPuRLO7BFr1pk1fAX2HD7mMt-xmqM1K4l5GCoYFGKju5vCYVY1PonqkeAyMbyojAqz1Y916I0PW2Ba1QzKTREhcudJpVI_RoLMDN85RSK8IDzDmSqzBp0jMeJMdqR_vr_niRE0EqHUsCvPPbskLlxyb6pDfwjBUsisc2fBt9aK01THLZXHzRx8x-KE_W2D4bZCVWQfOc1DUmRhmv1orkBenTp6llIbFX9f8JJVH_FIZWKmWYTlMywxqLOnrZEsPsAt1bl7zjyxje9DfPLiQ68VkLuXwZSjTmKDcBtkuTkA0zO68_Hua8XfRtB_t1cf-G_y2_lO0V "The Session Object"

#### Source:

<pre>
<code>
@startuml
Session <|-- CPOSession
Session <|-- EMSPSession
 
 
abstract class Session {
    Virtual object
    ----
    **Non abstract fields that are shared between both platforms**
    ....
    + id : str
    + info : CDRInfoType
    + status : str
    ----
    **Abstract fields that are platform specific**
    ....
    {abstract} # endpoints : Endpoint[]
}
 
class CPOSession {
    Describes a session in the CPO platform
    ----
    + endpoints : Endpoint[]; // options = {uri, charging_profile}
}
 
class EMSPSession {
    Describes a session in the eMSP platform
    ----
    + endpoints : Endpoint[]; // options = {uri, stop_session}
}
 
note bottom of CPOSession
    Fields that contain information
    about the session object on the
    CPO platform.
end note
 
note bottom of EMSPSession
    Fields that contain information
    about the session object on the
    eMSP platform.
end note
@enduml
</code>
</pre>


### Session Sequence Diagram

![Session Sequence Diagram][session-sequence-diagram]
[session-sequence-diagram]: http://plantuml.com/plantuml/svg/bP712i8m38RlVOgm-_e0eeBCWWTbW-qeI5aZvb9BstaPlhljtDX46UuIIFxawmSrqdggoKZj8ScAF65cEi5JMIGCcAmzFQH722kX3HNIBSHq1KLULj0wT8xksbrGAtCdxPzdhQINcx1RlhEH4WzPB2EbjXYJ7jEzi4xJFhJe6wj1X6PW0LFuoGF6EV-IsrNP0Th99Hy47MyiBRHiZ5fa-PVZNXn59UOaPvskfCdTPfr-U4mctP--0000 "Session Sequence Diagram"


#### Source:

<pre>
<code>
@startuml
participant "CPO"
participant "eMSP"
 
activate CPO
 
CPO -> eMSP: POST {sessions_endpoint}\ndata=CPOSession
activate eMSP
eMSP -> eMSP: create session
CPO <-- eMSP: return EMSPSession
 
deactivate eMSP
 
...
 
CPO -> eMSP: PATCH {EMSPSession.endpoints.uri}\ndata=CPOSession
activate eMSP
eMSP -> eMSP: update session
CPO <-- eMSP: return EMSPSession
deactivate eMSP
 
...
 
CPO -> eMSP: DELETE {EMSPSession.endpoints.uri}
activate eMSP
eMSP -> eMSP: finish session
CPO <-- eMSP: return
deactivate eMSP
 
deactivate CPO
 
@enduml
</code>
</pre>

---
