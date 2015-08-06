## Status codes

There are two types of status codes:
- Transport related (HTTP)
- Content related (OCPI)

The transport layer ends after a message is correctly parsed into a (semantically unvalidated) JSON structure. When a message does not contain a valid JSON string, the HTTP error `400 - Bad request` is returned.

Requests that reach the OCPI layer should return an OCPI response message with a `status_code` field as defined below.

| Range | Description   |
|-------|---------------|
| 1xxx  | Success       |
| 2xxx  | Client errors |
| 3xxx  | Server errors |

When the status code is in the success range (1xxx), the `data` field in the response message should contain the information as specified in the protocol. Otherwise the `data` field is unspecified and may be omitted, `null` or something else that could help to debug the problem from a programmer's perspective. For example, it could specify which fields contain an error or are missing.


### 1xxx: Success

| Code | Description                             |
|------|-----------------------------------------|
| 1000 | Generic success code                    |


### 2xxx: Client errors

| Code | Description                             |
|------|-----------------------------------------|
| 2000 | Generic client error                    |
| 2001 | Invalid or missing parameters           |


### 3xxx: Server errors

| Code | Description                             |
|------|-----------------------------------------|
| 3000 | Generic server error                    |
| 3001 | Unsupported version. The client tried to register for a version that is not supported by the client itself. |

