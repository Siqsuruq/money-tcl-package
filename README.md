# Money Package Documentation

The `money` package is a simple and flexible money-handling package built using the NX framework and `math::decimal`. It provides utilities for common monetary calculations like addition, subtraction, percentages, and rounding. Rounding is half-even (banker's rounding).

---

## Object Properties

- **`version`**: (Default: `"1.0.3"`)
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

All values must be plain decimal numbers (e.g. `1000.50`). Thousands separators such as `1,000.50` are not accepted as input.

- **`add {a b}`**
  Adds two decimal values.
  **Returns**: The sum, rounded to the specified precision.

- **`subtract {a b}`**
  Subtracts the second value from the first.
  **Returns**: The difference, rounded to the specified precision.

- **`multiply {a b}`**
  Multiplies two decimal values.
  **Returns**: The product, rounded to the specified precision.

- **`divide {a b}`**
  Divides the first value by the second.
  **Returns**: The quotient, rounded to the specified precision.
  **Error**: Raises an error if dividing by zero.

- **`round {val {round_digits ""}}`**
  Rounds a value (half-even) to the specified number of decimal places.
  **Parameters**:
  - `val`: Value to round.
  - `round_digits` (optional): Precision for rounding (defaults to the `round_digits` property).
  **Returns**: The rounded value.

---

### Percentage Methods

- **`addPercent {value percent}`**
  Adds a percentage to a value (`value + value * percent / 100`).

- **`subtractPercent {value percent}`**
  Subtracts a percentage from a value (`value - value * percent / 100`).

- **`getPercent {value percent}`**
  Returns the given percentage of a value (`value * percent / 100`).

- **`get100Percent {value percent}`**
  Reverses `addPercent`: given a value that already includes a percentage, returns the base amount (`value / (100 + percent) * 100`). For example, extracting the net amount from a gross price that includes tax.

All percentage methods return the result rounded to the specified precision.

---

### Other Utilities

- **`change {amount value}`**
  Calculates the change by subtracting `value` from `amount`. Negative if `value` exceeds `amount`.

- **`average {vlist}`**
  Calculates the average of a list of values.
  **Error**: Raises an error if the list is empty.

- **`percentagechange {orig new}`**
  Calculates the percentage change from `orig` to `new`.
  **Returns**: The change prefixed with `+` or `-` and suffixed with `%` (e.g. `+50.00%`).
  **Note**: If `orig` is zero, an error message string is **returned** (not raised): `Error: Percentage change cannot be calculated when the original value is zero.`

- **`withSeparators {val {sep ,} {dec .}}`**
  Formats a value for display with grouped thousands. The value is rounded first.
  **Parameters**:
  - `val`: Value to format.
  - `sep` (optional): Thousands separator (default `,`).
  - `dec` (optional): Decimal mark (default `.`).
  **Returns**: A display string, e.g. `1,234,567.89`.
  **Note**: Output only. Do not pass the result back into other `money` methods.

---

## Usage

```tcl
package require nx
package require math::decimal
package require money

puts [money add 100.125 200.375]          ;# 300.50
puts [money addPercent 100 15]            ;# 115.00
puts [money get100Percent 118 18]         ;# 100.00
puts [money withSeparators 1234567.891]   ;# 1,234,567.89
puts [money withSeparators 1234.5 . ,]    ;# 1.234,50

money setRoundDigits 3
puts [money add 100.125 200.375]          ;# 300.500
```

---

## Running the tests

```
cd tests
tclsh all.tcl
```