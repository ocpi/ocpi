# _Sessions_ Business Object

*General description of the business object*

The session object describes one charging session in a roaning scenario.
The object is virtual and lives between the operator's and provider's
systems. Each of the two parties hold a inheritance of this virtual
object.


## 1. Inheritances

*List all inheritors.*

### 1.1 Operator Inheritor

The operator inheritance of the session object contains charging station
related data.


### 1.2 Provider Inheritor

The provider inheritance of the session object contains user and billing
related data.


## 2. Flow and Lifecycle

*Describe the status of the objects, how it is created and destroyed,
when and through which action it gets inherited. Name the owner. Explain
the purpose.*


### 2.1 Operator initializes

![Lifecycle Operator initialized][location-lifecycle-1]


### 2.2 Provider initializes

![Lifecycle Provider initialized][location-lifecycle-2]


## 3. Interfaces and endpoints

*Explain which interfaces are available and which party should implement
which one.*


### 3.1 Operator Interface

*Describe the interface in detail.*

Endpoint structure /xxx/yyy/

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      |                                                      |
| POST     |                                                      |
| PUT      |                                                      |
| PATCH    |                                                      |
| DELETE   |                                                      |


### 3.2 Provider Interface

*Describe the interface in detail.*

Endpoint structure /xxx/yyy/

| Method   | Description                                          |
| -------- | ---------------------------------------------------- |
| GET      |                                                      |
| POST     |                                                      |
| PUT      |                                                      |
| PATCH    |                                                      |
| DELETE   |                                                      |




## Object description

*Describe the structure of this object.*

### Primary Object

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |


### Inheritor Object #1

*If different from the primary object*

| Property  | Type        | Card. | Description                    |
|-----------|-------------|-------|--------------------------------|
|           |             |       |                                |
|           |             |       |                                |




## Data types

*Describe all datatypes used in this object*

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

### Lifecycle Operator initialized

![Lifecycle][location-lifecycle-1]
[location-lifecycle-1]: http://plantuml.com:80/plantuml/svg/TKyn3eD03Dll5H4x7q0LEnCCPM9AGwIcKezJ527rzmMn75pO4Zjsx8HgGf8m6bHzOaLR5BhuPXN3I5o5b9yCAb_K7_Il3vCLvBBAp1TzcEgwBPGDF4WPZTk0PB9kK-b-1M0tSbDkTdAikPzVAFWu72cT2WqCu_CKq-qvytsJdFDJdTNUWpy0 "Lifecycle"


#### Source:

<pre>
<code>
@startuml
participant "Operator Inheritance"
participant "Primary Object"
participant "Provider Inheritance"

[--> "Primary Object": <create>
activate "Primary Object"
"Primary Object" -> "Operator Inheritance": <inherit>
activate "Operator Inheritance"

"Operator Inheritance" -> "Provider Inheritance": PUT
activate "Provider Inheritance"

deactivate "Primary Object"
deactivate "Operator Inheritance"
deactivate "Provider Inheritance"

@enduml
</code>
</pre>


### Lifecycle Provider initialized

![Lifecycle][location-lifecycle-2]
[location-lifecycle-2]: http://plantuml.com:80/plantuml/svg/TP2_2eD03CRtUuhWxWj8SNVIeOuEQGmqXPv724BVlgBBwSKjoPVlbpy9rOGaOJIe-iIAjYXqySqgXf6u2Ybl6LI-g3_eNnycAyHbbPal_Z3LTLiu6tYGCXgt0SbatQAIVYt00NAcR3WvqZFFNSYlxt3t1GqCupF3-dyACzzVack-_Upszlu3 "Lifecycle"


#### Source:

<pre>
<code>
@startuml
participant "Operator Inheritance"
participant "Primary Object"
participant "Provider Inheritance"

]--> "Primary Object": <create>
activate "Primary Object"
"Primary Object" -> "Provider Inheritance": <inherit>
activate "Provider Inheritance"

"Provider Inheritance" -> "Operator Inheritance": PUT
activate "Operator Inheritance"

deactivate "Primary Object"
deactivate "Operator Inheritance"
deactivate "Provider Inheritance"

@enduml
</code>
</pre>

---
