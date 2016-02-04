
# Version information endpoint

This endpoint lists all the available OCPI versions and the corresponding URLs to
where version specific details such as the supported endpoints can be found.

Example endpoint structure: `/ocpi/cpo/versions` and `/ocpi/emsp/versions`
The exact URL to the implemented version endpoint should be given (offline) to parties that interface
with your OCPI implementation, this endpoint is the starting point for discovering locations
of the different modules and version of OCPI that have been implemented.

Both the CPO and the eMSP must have this endpoint.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method   | Description                                                             |
| -------- | ----------------------------------------------------------------------- |
| GET      | Fetch information about the supported versions.                         |
<div><!-- ---------------------------------------------------------------------------- --></div>


## Data

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property | Type     | Card. | Description                               |
|----------|----------|-------|-------------------------------------------|
| versions | Version  | +     | A list of supported OCPI versions.        |
<div><!-- ---------------------------------------------------------------------------- --></div>


### Version *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property | Type                        | Card. | Description                               |
|----------|-----------------------------|-------|-------------------------------------------|
| version  | decimal                     | 1     | The version number.                       |
| url      | [URL](types.md#14_url_type) | 1     | URL to the endpoint containing version specific information. |
<div><!-- ---------------------------------------------------------------------------- --></div>


## GET

Fetch all supported OCPI versions of this CPO or eMSP.

### Example

```json
[
    {
        "version": "1.9",
        "url": "https://example.com/ocpi/cpo/1.9/"
    },
    {
        "version": "2.0",
        "url": "https://example.com/ocpi/cpo/2.0/"
    }
]
```


# Version details endpoint

Example: `/ocpi/cpo/2.0/` and `/ocpi/emsp/2.0/`

This endpoint lists the supported endpoints and their URLs for a specific OCPI version. To notify the other party that the list of endpoints of your current version has changed, you can send a PUT request to the corresponding credentials endpoint (see the credentials chapter).

Both the CPO and the eMSP must have this endpoint.

<div><!-- ---------------------------------------------------------------------------- --></div>
| Method   | Description                                                             |
| -------- | ----------------------------------------------------------------------- |
| GET      | Fetch information about the supported endpoints for this version.       |
<div><!-- ---------------------------------------------------------------------------- --></div>


## Data

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property  | Type                                | Card. | Description                                     |
|-----------|-------------------------------------|-------|-------------------------------------------------|
| version   | [decimal](types.md#13_decimal_type) | 1     | The version number.                             |
| endpoints | Endpoint                            | +     | A list of supported endpoints for this version. |
<div><!-- ---------------------------------------------------------------------------- --></div>


### Endpoint *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property    | Type                   | Card. | Description                               |
|-------------|------------------------|-------|-------------------------------------------|
| identifier  | ModuleID               | 1     | Endpoint identifier.                      |
| url         | [URL](types.md#14_url) | 1     | URL to the endpoint.                      |
<div><!-- ---------------------------------------------------------------------------- --></div>


### ModuleID *enum*

The Module identifiers for each endpoint are in the beginning of each *Module* chapter. The following table contains the list of modules in this version of OCPI

<div><!-- ---------------------------------------------------------------------------- --></div>
| Module                                       | ModuleID    | Remark                            |
|----------------------------------------------|-------------|-----------------------------------|
| [CDRs](mod_cdrs.md)                          | cdrs        |                                   |
| [Credentials & registration](credentials.md) | credentials | Required for all implementations  |
| [Locations](mod_locations.md)                | locations   |                                   |
| [Sessions](mod_sessions.md)                  | sessions    |                                   |
| [Tariffs](mod_tariffs.md)                    | tariffs     |                                   |
| [Tokens](mod_tokens.md)                      | tokens      |                                   |
<div><!-- ---------------------------------------------------------------------------- --></div>


## GET

Fetch information about the supported endpoints and their URLs for this version.

### Example

```json
{
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
```
