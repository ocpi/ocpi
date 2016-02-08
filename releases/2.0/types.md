## Types

### 1.1 CiString *type*

Case Insensitive String. Only printable ASCII allowed.

### 1.2 DateTime *type*
 
All timestamps are formatted as string(25) using the combined date and time format from the ISO 8601 standard. The absence of the timezone designator implies a UTC timestamp.

__Known issue in OCPI 2.0: time zones and the use of time zones is not defined strictly enough in OCPI 2.0, and therefor can not be guaranteed to work correctly between parties. It is advised to have additional agreements between parties when using OCPI 2.0 over different times zones, or to use OCPI 2.0 only within the same time zone.__ This will be fixed in the next version of OCPI. 

Example:

    2015-06-29T22:39:09+02:00
    2015-06-29T20:39:09Z
    2015-06-29T20:39:09

Note: +00:00 is not the same as UTC.

   
### 1.3 decimal *type*

Decimals are formatted as strings following JSONs number format. They are explicitly expressed as strings to make it clear that they should be interpreted as exact decimals and not as floating points or doubles.

Example:

    "0.68"
    "3.1415"

    
### 1.4 DimensionType *enum*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Value        | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| ENERGY       | defined in kWh, default step_size is 1 Wh                          |
| FLAT         | flat fee, no unit                                                  |
| MAX_CURRENT  | defined in A (Ampere), Maximum current                             |
| MIN_CURRENT  | defined in A (Ampere), Minimum current                             |
| PARKING_TIME | time not charging: defined in hours, default step_size is 1 second |
| TIME         | time charging: defined in hours, default step_size is 1 second     |
<div><!-- ---------------------------------------------------------------------------- --></div>


### 1.5 DisplayText *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property        | Type                           | Card. | Description                                                       |
|-----------------|--------------------------------|-------|-------------------------------------------------------------------|
| language        | [string](#16-string-type)(2)   | 1     | Language Code ISO 639-1                                           |
| text            | [string](#16-string-type)(512) | 1     | Text to be displayed to a end user. No markup, html etc. allowed. |
<div><!-- ---------------------------------------------------------------------------- --></div>

Example:
 
    {
      "language": "en",
      "text": "Standard Tariff"
    }


### 1.6 string *type*

Case Sensitive String. Only printable ASCII allowed. All strings in
messages and enumerations are case sensitive, unless explicitly stated
otherwise.
    

### 1.7 URL *type*

An URL a string(255) type following the [w3.org spec](http://www.w3.org/Addressing/URL/uri-spec.html).
