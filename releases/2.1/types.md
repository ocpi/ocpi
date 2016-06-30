# Types

## 1.1 CiString *type*

Case Insensitive String. Only printable ASCII allowed.

## 1.2 DateTime *type*
 
All timestamps are formatted as string(25) using the combined date and time format from the ISO 8601 standard. All timestamps SHALL be in UTC. The absence of the timezone designator implies a UTC timestamp.

Example:

    2015-06-29T22:39:09+02:00
    2015-06-29T20:39:09Z
    2015-06-29T20:39:09

Note: +00:00 is not the same as UTC.

    
## 1.3 DisplayText *class*

<div><!-- ---------------------------------------------------------------------------- --></div>
| Property        | Type                           | Card. | Description                                                       |
|-----------------|--------------------------------|-------|-------------------------------------------------------------------|
| language        | [string](#15-string-type)(2)   | 1     | Language Code ISO 639-1                                           |
| text            | [string](#15-string-type)(512) | 1     | Text to be displayed to a end user. No markup, html etc. allowed. |
<div><!-- ---------------------------------------------------------------------------- --></div>

Example:
 
    {
      "language": "en",
      "text": "Standard Tariff"
    }


## 1.4 number *type*

Numbers in OCPI are formatted as JSON numbers. 
Unless mentioned otherwise, numbers use 4 decimals and a *sufficiently large amount* of digits.


## 1.5 string *type*

Case Sensitive String. Only printable ASCII allowed. All strings in
messages and enumerations are case sensitive, unless explicitly stated
otherwise.
    

## 1.6 URL *type*

An URL a string(255) type following the [w3.org spec](http://www.w3.org/Addressing/URL/uri-spec.html).
