# Transport and format

## JSON / HTTP implementation guide

The OCPI protocol is based on HTTP and uses the JSON format. It follows a RESTful architecture for webservices where possible.

### Security and authentication

The interfaces are protected on HTTP transport level, with SSL and token based authentication. Please note that this mechanism does **not** require client side certificates for authentication, only server side certificates in order to setup a secure SSL connection.

### Pull and Push

OCPI supports both 'pull' and 'push' models. 

- Push: Changes in objects, and new objects are send (semi) real-time to receiver.
- Pull: Receiver request a (full) list of objects every X times.

OCPI doesn't require parties to implement 'push'. 
'pull' is required, a receiver needs to be able to get 'in-sync' after a period of connection loss.

It is possible to implement a 'pull' only OCPI implementation, it might be a good starting point for an OCPI implementation.
However, it is strongly advised to implement 'push' for production systems that have to handle some load, 
especially when a number of clients are requesting long lists frequently. 
'Push' implementation tend to use much less resources.
It is therefor advised to clients 'pulling' lists from a server to do this on a relative low polling interval: think in hours, not minutes, and to introduce some splay (randomize the length of the poll interface a bit).   


### Request format

Each HTTP request must add a 'Authorization' header. The header looks as follows:

```
  Authorization: Token IpbJOXxkxOAuKR92z0nEcmVF3Qw09VG7I7d/WCg0koM=
```

The literal 'Token' indicates that the token based authentication mechanism is used. Its parameter is a string consisting of printable, non-whitespace ASCII characters. The token must uniquely identify the requesting party. This way, the server can use this to link data and commands to this party's account.

The request method can be any of [GET](#get), [PUT](#put), [PATCH](#patch) or DELETE. The OCPI protocol uses them in a way similar to REST APIs.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Method           | Description                          
|------------------|-------------------------------------------------------|
| [GET](#get)      | Fetches objects or information. |
| POST             | Creates new objects or information. |
| [PUT](#put)      | Updates existing objects or information. |
| [PATCH](#patch)  | Partially updates existing objects or information. |
| DELETE           | Removes existing objects or information. |
<div><!-- ---------------------------------------------------------------------------- --></div>

The mimetype of the request body is `application/json` and may contain the data as documented for each endpoint.


#### GET
A server is not required to return all objects to a client, the server might for example not send all CDRs to a client, 
because some CDRs do not belong to this client.  

When a client receives objects from the server that contain invalid JSON or invalid OCPI objects (For example: missing fields), 
the client has no way of letting this know to the server. It is advised to log these errors and contact the server administrator about this.
When a list of objects contains some objects that are correct and some with 'problems' the client should at least process the correct OCPI objects. 
 
##### Pagination

All GET methods that return a list of objects have pagination, this allows a client and server to control the amount of objects 
returned in the response to a GET request, while still enabling the client to retrieve all objects by doing multiple request 
with different parameters. Without pagination the server had to return all objects in one response that could potentially contain millions of objects. 

To enable pagination of the returned list of objects, additional URL parameters are allowed for the GET request and additional 
headers need to be added to the response.

##### Paginated Request
The following table lists all the parameters that have to be supported, but might be omitted by a client request.

<div><!-- ---------------------------------------------------------------------------- --></div>

| Parameter | Description                                            |
|-----------|--------------------------------------------------------|
| offset    | The offset of the first object returned. Default is 0 (the first object). |
| limit     | Maximum number of objects to GET. Note: the server might decide to return fewer objects, either because there are no more objects, or the server limits the maximum number of objects to return. This is to prevent, for example, overloading the system. |
<div><!-- ---------------------------------------------------------------------------- --></div>

Example: With offset=0 and limit=10 the server shall return the first 10 records (if 10 objects match the request). Then next page starts with offset=10.


##### Paginated Response
For pagination to work correctly it is important that multiple calls to the same URL (including query parameters) 
result in the same objects being returned by the server.
For this to be the case it is important that the sequence of objects does not change. (or as little as possible)
It is best practice to return the oldest (by creation date, not the `last_updated` field) first.
While a client crawls over the pages (multiple GET requests every time to the 'next' page Link), a new object might be created on the server. 
The client detects this: the `X-Total-Count` will be higher on the next call.
But the client doesn't have to correct for this. Only the last page will be different (or an additional page). 
So the client will not be required to crawl all pages all over again, when the client has reached to last page it has retrieved all relevant pages and is up to date.

Note: Some query parameters can cause concurrency problems. For example: the `date_to` query parameter. 
When there are for example 1000 objects matching a query for all objects with `date_to` before 2016-01-01.
While crawling over the pages one of these objects is update. 
The client detects this: `X-Total-Count` will be lower in a next request. 
It is advised redo the previous GET but then with the `offset` lowered by 1 (if the `offset` was not 0) and after that continue crawling the 'next' page links.
When an object before this page has been updated, then the client has missed 1 object.

HTTP headers that have to be added to any paginated GET response.

<div><!-- ---------------------------------------------------------------------------- --></div>

| HTTP Parameter  | Description                                                                 |
|-----------------|-----------------------------------------------------------------------------|
| Link            | Link to the 'next' page should be provided, when this is NOT the last page. The Link should also contain any filters present in the original request. See example below. |
| X-Total-Count   | (Custom HTTP Header) Total number of objects available in the server system that match the give query (including the given query parameters for example: `date_to` and `date_from` but excluding `limit` and `offset`) and that are available to this client. For example: The CPO server might return less CDR objects to an eMSP then the total number of CDRs available in the CPO system. |
| X-Limit         | (Custom HTTP Header) Number of objects that are returned. Note that this is an upper limit, if there are not enough remaining objects to return, fewer objects than this upper limit number will be returned. |
<div><!-- ---------------------------------------------------------------------------- --></div>

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->


##### Pagination Examples

Example of a required OCPI pagination link header:

```   
  Link: <https://www.server.com/ocpi/cpo/2.0/cdrs/?offset=150&limit=50>; rel="next"
```   

After the client has called the given "next" page URL above the Link parameter will most likely look like this:

```   
  Link: <https://www.server.com/ocpi/cpo/2.0/cdrs/?offset=200&limit=50>; rel="next"
```   

Example of a query with filters: Client does a GET to: 

```   
  https://www.server.com/ocpi/cpo/2.0/cdrs/?date_from=2016-01-01T00:00:00Z&date_to=2016-12-31T23:59:59Z
```   

The server should return (when the server has enough objects and the limit is the amount of objects the server wants to send is 100.)
_(This example should have been on 1 line, but didn't fit the paper width.)_ 

```  
  Link: <https://www.server.com/ocpi/cpo/2.0/cdrs/?offset=100
                 &limit=100&date_from=2016-01-01T00:00:00Z&date_to=2016-12-31T23:59:59Z>; rel="next"
```

Example of a server limiting the amount of objects returned: Client does a GET to:

```   
  https://www.server.com/ocpi/cpo/2.0/cdrs/?limit=2000
```   

The server should return (when the server has enough objects and the limit is the amount of objects the server wants to send is 100.) The `X-Limit` HTTP parameter should be set to 100 as well.

```   
  Link: <https://www.server.com/ocpi/cpo/2.0/cdrs/?offset=100&limit=100>; rel="next"
```   


#### PUT
A PUT request must specify all required fields of an object (similar to a POST request). 
Optional fields that are not included will revert to their default value which is either specified in the protocol or NULL.


#### PATCH
A PATCH request must only specify the object's identifier (if needed to identify this object) and the fields to be updated. Any fields (both required or optional) that are left out remain unchanged.

The mimetype of the request body is `application/json` and may contain the data as documented for each endpoint.

In case a PATCH request fails, the client is expected to call the GET method to check the state of the object in the other party's system. If the object doesn't exist, the client should do a [PUT](#put). 


### Client owned object push
Normal client/server RESTful services work in a way where the Server is the owner of the objects that are created. The client requests a POST method with an object to the end-point URL. The response send by the server will contain the URL to the new object. The client will request only one server to create a new object, not multiple servers.

Many OCPI modules work differently: the client is the owner of the object and only pushes the information to one or more servers for information sharing purposes.   
For example: the CPO owns the Tariff objects and pushes them to a couple of eMSPs, so each eMSP gains knowledge of the tariffs that the CPO will charge them for their customers' sessions. eMSP might receive Tariff objects from multiple CPOs. They need to be able to make a distinction between the different tariffs from different CPOs. 

The distinction between objects from different CPOs/eMSPs is made based on a {[country-code](credentials.md#credentials-object)} and {[party-id](credentials.md#credentials-object)}.
The [country-code](credentials.md#credentials-object) and [party-id](credentials.md#credentials-object) of the other party are received during the [credentials](credentials.md#credentials-object) handshake, so that a server might know the values a client will use in an URL.

Client owned object URL definition: {base-ocpi-url}/{end-point}/{country-code}/{party-id}/{object-id}

Example of a URL to a client owned object
```   
  https://www.server.com/ocpi/cpo/2.0/tariffs/NL/TNM/14
```   

POST is not supported for these kind of modules.
PUT is used to send new objects to the servers. 

If a client tries to access an object with a URL that has a different [country-code](credentials.md#credentials-object) and/or [party-id](credentials.md#credentials-object) then given during the [credentials](credentials.md#credentials-object) handshake, it is allowed the respond with a HTTP 404 status code, this way blocking client access to objects that do not belong to them.


#### Errors
When a client pushes a client owned object, but the {object-id} in the URL is different from the id in the object being pushed. A Server implementation is advised to return an [OCPI status code](status_codes.md#status-codes): [2001](status_codes.md#status-codes).
 

### Response format

When a request cannot be accepted, an HTTP error response code is expected including a JSON object that contains more details. HTTP status codes are described on [w3.org](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html).

The content that is sent with all the response messages is an 'application/json' type and contains a JSON object with the following properties:

<div><!-- ---------------------------------------------------------------------------- --></div>

| Property           | Type                                  | Card.   | Description                                               |
|--------------------|---------------------------------------|---------|-----------------------------------------------------------|
| data               | Array or Object or String             | * or ?  | Contains the actual response data object or list of objects from each request, depending on the cardinality of the response data, this is an array (card. * or +), or a single object (card. 1 or ?) |
| status_code        | int                                   | 1       | Response code, as listed in [Status Codes](status_codes.md#status-codes), indicates how the request was handled. To avoid confusion with HTTP codes, at least four digits are used.                              |
| status_message     | [string](types.md#15-string-type)     | ?       | An optional status message which may help when debugging. |
| timestamp          | [DateTime](types.md#12-datetime-type) | 1       | The time this message was generated.                      |
<div><!-- ---------------------------------------------------------------------------- --></div>

For brevity's sake, any further examples used in this specification will only contain the value of the "data" field. In reality, it will always have to be wrapped in the above response format.

#### Example: Version information response (list of objects)

```json
{
	"data": [{
		"version": "1.9",
		"url": "https://example.com/ocpi/cpo/1.9/"
	}, {
		"version": "2.0",
		"url": "https://example.com/ocpi/cpo/2.0/"
	}],
	"status_code": 1000,
	"status_message": "Success",
	"timestamp": "2015-06-30T21:59:59Z"
}
```

#### Example: Version details response (one object)

```json
{
	"data": {
		"version": "2.0",
		"endpoints": [{
			"identifier": "credentials",
			"url": "https://example.com/ocpi/cpo/2.0/credentials/"
		}, {
			"identifier": "locations",
			"url": "https://example.com/ocpi/cpo/2.0/locations/"
		}]
	},
	"status_code": 1000,
	"status_message": "Success",
	"timestamp": "2015-06-30T21:59:59Z"
}
```

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->


#### Example: Tokens GET Response with one Token object. (CPO end-point) (one object)

```json
{
	"data": {
		"uid": "012345678",
		"type": "RFID",
		"auth_id": "FA54320",
		"visual_number": "DF000-2001-8999",
		"issuer": "TheNewMotion",
		"valid": true,
		"allow_whitelist": true
	},
	"status_code": 1000,
	"status_message": "Success",
	"timestamp": "2015-06-30T21:59:59Z"
}
```


#### Example: Tokens GET Response with list of Token objects. (eMSP end-point) (list of objects)

```json
{
	"data": [{
		"uid": "100012",
		"type": "RFID",
		"auth_id": "FA54320",
		"visual_number": "DF000-2001-8999",
		"issuer": "TheNewMotion",
		"valid": true,
		"allow_whitelist": true
	}, {
		"uid": "100013",
		"type": "RFID",
		"auth_id": "FA543A5",
		"visual_number": "DF000-2001-9000",
		"issuer": "TheNewMotion",
		"valid": true,
		"allow_whitelist": true
	}, {
		"uid": "100014",
		"type": "RFID",
		"auth_id": "FA543BB",
		"visual_number": "DF000-2001-9010",
		"issuer": "TheNewMotion",
		"valid": false,
		"allow_whitelist": true
	}],
	"status_code": 1000,
	"status_message": "Success",
	"timestamp": "2015-06-30T21:59:59Z"
}
```


#### Example: Response with an error (contains no data field)

```json
{
	"status_code": 2001,
	"status_message": "Missing required field: type",
	"timestamp": "2015-06-30T21:59:59Z"
}
```

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

<!--
  Add some whitelines for PDF generation fix, TODO check in new PDf versions 
-->


## Interface endpoints

As OCPI contains multiple interfaces, different endpoints are available for messaging. The protocol is designed such that the exact URLs of the endpoints can be defined by each party. It also supports an interface per version.

The locations of all the version specific endpoints can be retrieved by fetching the API information from the versions endpoint. Each version specific endpoint will then list the available endpoints for that version. It is strongly recommended to insert the protocol version into the URL.

For example: `/ocpi/cpo/2.0/locations` and `/ocpi/emsp/2.0/locations`.

The URLs of the endpoints in this document are descriptive only. The exact URL can be found by fetching the endpoint information from the API info endpoint and looking up the identifier of the endpoint.


<div><!-- ---------------------------------------------------------------------------- --></div>

| Operator interface         | Identifier  | Example URL                                   |
| -------------------------- | ----------- | --------------------------------------------- |
| Credentials                | credentials | https://example.com/ocpi/cpo/2.0/credentials  |
| Charging location details  | locations   | https://example.com/ocpi/cpo/2.0/locations    |
<div><!-- ---------------------------------------------------------------------------- --></div>


<div><!-- ---------------------------------------------------------------------------- --></div>

| eMSP interface             | Identifier  | Example URL                                       |
| -------------------------- | ----------- | ------------------------------------------------- |
| Credentials                | credentials | https://example.com/ocpi/emsp/2.0/credentials     |
| Charging location updates  | locations   | https://example.com/ocpi/emsp/2.0/locations       |
<div><!-- ---------------------------------------------------------------------------- --></div>


## Offline behaviour

During communication over OCPI, it might happen that one of the communication parties is unreachable for an amount of time. 
OCPI works event based, new messages and status are pushed from one party to another. When communication is lost, updates cannot be delivered.

OCPI messages should not be queued. When a client does a POST, PUT or PATCH request and that requests fails or times out, 
the client should not queue the message and retry the same message again on a later time. 

When the connection is re-established, it is up to the target-server of a connection to GET the current status from to source-server to get back in-sync. 
For example: 
- CDRs of the period of communication loss can be rerieved with a GET command on the CDRs module, with filters to retrieve only CDRs of the period since the last CDR was received.
- Status of EVSEs (or Locations) can be retrieved by calling a GET on the Locations module.
