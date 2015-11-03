## Types

### 1.1 Dimension

| Property        | Type          | Card. | Description                         |
|-----------------|---------------|-------|-------------------------------------|
| type            | DimensionType | 1     | Type of dimension                   |
| volume          | decimal       | 1     | Duration of this period in seconds  |


### 1.2 DimensionType

| Value       | Description                                          |
| ----------- | ---------------------------------------------------- |
| energy      | Energy in kWh                                        |
| max_current | Maximum current in A (Ampere)                        |
| min_current | Minimum current in A (Ampere)                        |
| time        | Time in Hours                                        |
