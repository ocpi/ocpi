
## Credentials endpoint

Identifier: credentials

Example: `/ocpi/cpo/2.0/credentials` and `/ocpi/emsp/2.0/credentials`

| Method   | Description                                                              |
| -------- | ------------------------------------------------------------------------ |
| POST     | Provide the other party with credentials to your system (i.e. register). |
| PUT      | Update the other party's credentials to your system.                     |
| DELETE   | Inform the other party that its credentials to your system are deleted.  |


### Data

#### Credentials object

| Property | Type      | Card. | Description                               |
|----------|-----------|-------|-------------------------------------------|
| token    | String    | 1     | the token for the other party to authenticate in your system. |
| url      | String    | 1     | the URL to your API information endpoint (api_info). |


### Example

```json
{
    "token": "IpbJOXxkxOAuKR92z0nEcmVF3Qw09VG7I7d/WCg0koM=",
    "url": "https://example.com/cpo/2.0/"
}
```


### POST

Provide the other party with credentials to your system, this initiates the registration process.

### PUT

Update the other party's credentials to your system.

### DELETE

Inform the other party that its credentials to your system are now invalid and can no longer be used. This is the deregistration process.


## Registration

To register a CPO in a eMSP platform (or vice versa), the CPO must create a unique token that can be used for authenticating the eMSP. This token along with the versions endpoint will have to be sent to the eMSP in some secure way that is outside the scope of this protocol.

![the OCPI registration process](data/registration-sequence.png)
