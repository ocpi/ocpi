## Status codes

| Range | Description   |
|-------|---------------|
| 1xxx  | Success       |
| 2xxx  | Client errors |
| 3xxx  | Server errors |


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

