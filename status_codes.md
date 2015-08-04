## Status codes

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
| 2001 | Invalid message format (not JSON)       |
| 2002 | Invalid or missing parameters           |


### 3xxx: Server errors

| Code | Description                             |
|------|-----------------------------------------|
| 3000 | Generic server error                    |
| 3001 | Unsupported version. The client tried to register for a version that is not supported by the client itself. |

