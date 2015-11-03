## Types

### 1.1 Dimension

| Property        | Type          | Card. | Description                         |
|-----------------|---------------|-------|-------------------------------------|
| type            | DimensionType | 1     | Type of dimension                   |
| volume          | decimal       | 1     | Duration of this period in seconds  |


### 1.2 DimensionType

| Value        | Description                                          |
| ------------ | ---------------------------------------------------- |
| energy       | defined in kWh, default division is 1 Wh             |
| flat         | flat fee, no unit                                    |
| max_current  | defined in A (Ampere), Maximum current               |
| min_current  | defined in A (Ampere), Minimum current               |
| parking_time | defined in hours, default division is 1 second       |
| time         | defined in hours, default division is 1 second       |
