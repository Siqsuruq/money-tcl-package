# Money Class Documentation

The `money` class is a simple and flexible money-handling package built using the NX framework and `math::decimal`. It provides utilities for common monetary calculations like addition, subtraction, percentages, and rounding.

---

## Class Properties

- **`version`**: (Default: `"1.0.2"`)  
  The version of the `money` package.
  
- **`description`**:  
  A brief description of the package: `"Simple Money Package, using math::decimal"`.

- **`round_digits`**: (Default: `2`)  
  The number of decimal places for rounding operations.

---

## Public Methods

### General Methods

- **`setRoundDigits {digits}`**  
  Sets the number of decimal places used for rounding.  
  **Parameters**:
  - `digits`: Integer specifying the number of decimal places.
  
- **`getRoundDigits {}`**  
  Returns the current rounding precision.  

- **`version {}`**  
  Returns the version of the package.

---

### Arithmetic Methods

- **`add {a b}`**  
  Adds two decimal values.  
  **Parameters**:
  - `a`: First value (string or number).
  - `b`: Second value (string or number).  
  **Returns**: The sum, rounded to the specified precision.

- **`subtract {a b}`**  
  Subtracts the second value from the first.  
  **Parameters**:
  - `a`: First value.
  - `b`: Second value.  
  **Returns**: The difference, rounded to the specified precision.

- **`multiply {a b}`**  
  Multiplies two decimal values.  
  **Parameters**:
  - `a`: First value.
  - `b`: Second value.  
  **Returns**: The product, rounded to the specified precision.

- **`divide {a b}`**  
  Divides the first value by the second.  
  **Parameters**:
  - `a`: Dividend.
  - `b`: Divisor.  
  **Returns**: The quotient, rounded to the specified precision.  
  **Error**: Throws an error if dividing by zero.

- **`round {val {round_digits ""}}`**  
  Rounds a value to the specified number of decimal places.  
  **Parameters**:
  - `val`: Value to round.
  - `round_digits` (optional): Precision for rounding (defaults to the class's `round_digits` property).  
  **Returns**: The rounded value.

---

### Percentage Methods

- **`addPercent {value percent}`**  
  Adds a percentage to a value.  
  **Parameters**:
  - `value`: Base value.
  - `percent`: Percentage to add.  
  **Returns**: The updated value, rounded to the specified precision.

- **`subtractPercent {value percent}`**  
  Subtracts a percentage from a value.  
  **Parameters**:
  - `value`: Base value.
  - `percent`: Percentage to subtract.  
  **Returns**: The updated value, rounded to the specified precision.

- **`getPercent {value percent}`**  
  Calculates a percentage of a value.  
  **Parameters**:
  - `value`: Base value.
  - `percent`: Percentage to calculate.  
  **Returns**: The percentage, rounded to the specified precision.

- **`get100Percent {value percent}`**  
  Calculates a value adjusted by a given percentage relative to 100%.  
  **Parameters**:
  - `value`: Base value.
  - `percent`: Percentage adjustment.  
  **Returns**: The adjusted value, rounded to the specified precision.

---

### Other Utilities

- **`change {amount value}`**  
  Calculates the change by subtracting `value` from `amount`.  
  **Returns**: The change, rounded to the specified precision.

- **`average {vlist}`**  
  Calculates the average of a list of values.  
  **Parameters**:
  - `vlist`: List of values.  
  **Returns**: The average, rounded to the specified precision.  
  **Error**: Throws an error if the list is empty.

- **`percentagechange {orig new}`**  
  Calculates the percentage change between two values.  
  **Parameters**:
  - `orig`: Original value.
  - `new`: New value.  
  **Returns**: The percentage change, prefixed with `+` or `-`, rounded to the specified precision.  
  **Error**: Throws an error if the original value is zero.

---

## Usage

To use the `money` package, ensure you have the required dependencies and include the following in your Tcl script:

```tcl
package require nx
package require math::decimal
package require money

money create myMoney
myMoney setRoundDigits 3
puts [myMoney add 100.125 200.375]  ;# Outputs 300.500
puts [myMoney addPercent 100 15]    ;# Outputs 115.00
