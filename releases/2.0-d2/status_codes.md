# Status codes

There are two types of status codes:
- Transport related (HTTP)
- Content related (OCPI)

The transport layer ends after a message is correctly parsed into a (semantically unvalidated) JSON structure. When a message does not contain a valid JSON string, the HTTP error `400 - Bad request` is returned.

If a request is syntactically valid JSON and addresses an existing resource, no HTTP error should be returned. Those requests are supposed to have reached the OCPI layer.

Requests that reach the OCPI layer should return an OCPI response message with a `status_code` field as defined below.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Range | Description                                                                    |
|-------|--------------------------------------------------------------------------------|
| 1xxx  | Success                                                                        |
| 2xxx  | Client errors – The data sent by the client can not be processed by the server |
| 3xxx  | Server errors – The server encountered an internal error                       |
<div><!-- ---------------------------------------------------------------------------- --></div>

When the status code is in the success range (1xxx), the `data` field in the response message should contain the information as specified in the protocol. Otherwise the `data` field is unspecified and may be omitted, `null` or something else that could help to debug the problem from a programmer's perspective. For example, it could specify which fields contain an error or are missing.


## 1xxx: Success

<div><!-- ---------------------------------------------------------------------------- --></div>
| Code | Description                             |
|------|-----------------------------------------|
| 1000 | Generic success code                    |
<div><!-- ---------------------------------------------------------------------------- --></div>


## 2xxx: Client errors

Errors a server detected in the message sent by a client: The client did something wrong

<div><!-- ---------------------------------------------------------------------------- --></div>
| Code | Description                             |
|------|-----------------------------------------|
| 2000 | Generic client error                    |
| 2001 | Invalid or missing parameters           |
<div><!-- ---------------------------------------------------------------------------- --></div>


## 3xxx: Server errors

Error during processing of the OCPI payload in the server. The message was syntactically right but could not be processed by the server.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Code | Description                                                                |
|------|----------------------------------------------------------------------------|
| 3000 | Generic server error                                                       |
| 3001 | Unable to use the client's API. For example during the credentials registration: When the initializing party requests data from the other party during the open POST call to it’s credentials endpoint. If one of the GETs can not be processed, the party should return this error in the POST response. |
| 3002 | Unsupported version.                                                       |
| 3003 | No matching endpoints or expected endpoints missing between parties. Used during the registration process if the two parties do not have any mutual modules or endpoints available, or the minimum expected by the other party implementation. |
<div><!-- ---------------------------------------------------------------------------- --></div>
