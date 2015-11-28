## Transport and format

### JSON / HTTP implementation guide

The OCPI protocol is based on HTTP and uses the JSON format. It follows a RESTful architecture for webservices where possible.

#### Security and authentication

The interfaces are protected on HTTP transport level, with SSL and token based authentication. Please note that this mechanism does **not** require client side certificates for authentication, only server side certificates in order to setup a secure SSL connection.

#### Request format

Each HTTP request must add a 'Authorization' header. The header looks as following:

```
    Authorization: Token IpbJOXxkxOAuKR92z0nEcmVF3Qw09VG7I7d/WCg0koM=
```

The literal 'Token' indicates that the token based authentication mechanism is used. Its parameter is a string consisting of printable, non-whitespace ASCII characters. The token must uniquely identify the requesting party. The server can then use this to link data and commands to this party's account.

The request method can be any of GET, POST, PUT, PATCH or DELETE. The OCPI protocol uses them in a similar way as REST APIs do.

| Method | Description
|--------|----------------------------------------------------|
| GET    | Fetches objects or information.                    |
| POST   | Creates new objects or information.                |
| PUT    | Updates existing objects or information.           |
| PATCH  | Partially updates existing objects or information. |
| DELETE | Removes existing objects or information.           |

A PUT request must specify all required fields of an object (similar to a POST request). Optional fields that are not included will revert to their default value which is either specified in the protocol or NULL.

A PATCH request must only specify the object's identifier and the fields to be updated. Any fields (both required or optional) that are left out remain unchanged.

The mimetype of the request body is `application/json` and may contain the data as documented for each endpoint.


#### Response format

When a request cannot be accepted, an HTTP error response code is expected including a JSON object that contains more details. HTTP status codes are described on [w3.org](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html).

The content that is sent with all the response messages is a 'application/json' type and contains a JSON object with the following properties:

| Property       | Type                                  | Card. | Description                              |
|----------------|---------------------------------------|-------|------------------------------------------|
| data           | object                                | ?     | Contains the actual response data from each request. |
| status_code    | Integer                               | 1     | Response code, as listed in chapter *8. Status codes*, indicates how the request was handled. To avoid confusion with HTTP codes, at least four digits are used. |
| status_message | String                                | ?     | An optional status message which may help when debugging. |
| timestamp      | [DateTime](types.md#11_datetime_type) | 1     | When this message was generated, we don't have a use for this yet but might be useful if any party comes offline and sends a bunch of messages at once or even debugging purposes. |

For brevity's sake, any further example used in this specification will only contain the value of the "data" field. In reality, it will always have to be wrapped in the above response format.

##### Example

```json
{
	"status_code": 1000,
	"status_message": "Success",
	"timestamp": "2015-06-30T21:59:59Z",
	"data": {
        "version": "2.0",
        "endpoints": [
            {
                "identifier": "credentials",
                "url": "https://example.com/ocpi/cpo/2.0/credentials/"
            },
            {
                "identifier": "locations",
                "url": "https://example.com/ocpi/cpo/2.0/locations/"
            }
        ]
	}
}
```


### Interface endpoints

As OCPI contains multiple interfaces, different endpoints are available for messaging. The protocol is designed such that the exact URLs of the endpoints can be defined by each party. It also supports an interface per version.

The locations of all the version specific endpoints can be retrieved by fetching the API information from the versions endpoint. Each version specific endpoint will then list the available endpoints for that version. It is strongly recommended to insert the protocol version into the URL.

For example: `/ocpi/cpo/2.0/locations` and `/ocpi/emsp/2.0/locations`.

The URLs of the endpoints in this document are descriptive only. The exact URL can be found by fetching the endpoint information from the API info endpoint and looking up the identifier of the endpoint.

| Operator interface         | Identifier  | Example URL                                   |
| -------------------------- | ----------- | --------------------------------------------- |
| Credentials                | credentials | https://example.com/ocpi/cpo/2.0/credentials  |
| Charging location details  | locations   | https://example.com/ocpi/cpo/2.0/locations    |

| eMSP interface             | Identifier  | Example URL                                   |
| -------------------------- | ----------- | --------------------------------------------- |
| Credentials                | credentials | https://example.com/ocpi/emsp/2.0/credentials |
| Charging location updates  | locations   | https://example.com/ocpi/emsp/2.0/locations   |
