# FIFO Verification – Digital Design Verification Assignment

This repository contains the layered SystemVerilog testbench for verifying a parameterized Synchronous FIFO (First-In-First-Out) design, created as part of the Digital Verification Training at **NUST Chip Design Centre (NCDC)**.

## Objective

The goal of this project is to:

* Build a layered testbench using SystemVerilog.
* Apply advanced testbench architecture techniques.
* Fully verify the FIFO across various scenarios including corner cases.
* Use assertions and coverage to validate correctness.

---

## Features Verified

| #  | Feature                         | Description                                           | Status                        |
| -- | ------------------------------- | ----------------------------------------------------- | ----------------------------- |
| 1  | Reset Behavior                  | Asserts FIFO is empty on reset.                       | Passed                        |
| 2  | FIFO Full                       | Verifies full flag is set on DEPTH writes.            | Passed                        |
| 3  | FIFO Empty                      | Verifies empty flag is set on full readout.           | Passed                        |
| 4  | Read After Write                | Checks data integrity for single write and read.      | Passed                        |
| 5  | Empty Concurrent Read/Write     | Concurrent operation when FIFO is empty.              | Passed                        |
| 6  | Write When Full                 | Write attempt when FIFO is full.                      | Passed                        |
| 7  | Read When Empty                 | Read attempt when FIFO is empty.                      | Passed                        |
| 8  | Partial Concurrent Read/Write   | Mixed read/write operations on partially filled FIFO. | Passed                        |
| 9  | Concurrent Read/Write When Full | Read/write ops while FIFO is full.                    | Passed                        |
| 10 | Depth Tracking                  | Ensures FIFO fills to exact DEPTH.                    | Passed                        |
| 11 | Pointer Overflow                | Verifies safe operation near pointer limits.          | Passed                        |
| 12 | Reset Pointer Overflow          | Tests reset during overflow.                          | Failed (full flag misbehaves) |
| 13 | Reading When Full               | Verifies correct transition from full.                | Passed                        |
| 14 | Depth Test                      | Validates flag behavior at DEPTH boundary.            | Passed                        |
| 15 | Random Operations               | Performs 160,000 random ops with golden model check.  | Passed                        |

---

## Assertion Checks

**full\_test**
Ensures full flag remains high when full and no read occurs.

**empty\_test**
Checks that empty flag stays high during reads with empty FIFO.

**depth\_test**
Verifies FIFO becomes full exactly after `DEPTH` writes.


The scoreboard includes built-in assertions to validate the FIFO behavior:

- Checks that the **reference FIFO depth (`ref_fifo_depth`)** never becomes negative.
- Asserts that the **`full`** and **`empty`** output signals of the DUT match the internal model:
  - `assert(mon.full == full)`
  - `assert(mon.empty == empty)`
- On mismatch, errors are logged with timestamps and the mismatching values.

Additionally:
- **Reset behavior** is verified. After reset (`rst_n == 0`), the reference model is cleared and `empty` is expected to be `1`.
- The scoreboard prints **match/mismatch** logs on every read.
- Reports the remaining content in the reference model and final depth on failure.

These assertions help ensure robust functional correctness across directed and constrained-random tests.

---

## Coverage Model

* Write Enable & Read Enable Coverage
* Data Value Bins: Low / Mid / High
* Full & Empty Flag Transitions
* Cross Coverage: `write_en` vs `read_en` excluding simultaneous reads/writes

All coverage points were exercised across tests, achieving 100% coverage except for the failed reset corner case.

---

## DUT Specification

| Signal     | Width | Direction | Description                     |
| ---------- | ----- | --------- | ------------------------------- |
| `clk`      | 1     | Input     | Clock signal                    |
| `rst_n`    | 1     | Input     | Asynchronous reset (active low) |
| `wr_en`    | 1     | Input     | Write enable                    |
| `rd_en`    | 1     | Input     | Read enable                     |
| `data_in`  | N     | Input     | Input data (parameterized)      |
| `data_out` | N     | Output    | Output data (parameterized)     |
| `full`     | 1     | Output    | FIFO full flag                  |
| `empty`    | 1     | Output    | FIFO empty flag                 |

---

## Tools Used

* Simulator: Cadence Xcelium
* Language: SystemVerilog (IEEE 1800-2012)

---

## Directory Structure

```
.
├── fifo.sv                    # DUT
├── interface.sv              # FIFO interface
├── transaction.sv            # Base transaction class
├── generator.sv              # Transaction generator
├── driver.sv                 # DUT driver
├── monitor.sv                # Signal monitor
├── scoreboard.sv             # Checks data correctness
├── coverage.sv               # Coverage points
├── env.sv                    # Top-level environment
├── testbench.sv              # Program block to execute tests
├── assertions.sv             # Assertions for FIFO properties
├── tests/                    # Directed and random test generators
│   ├── test_fifo_full.sv
│   ├── test_fifo_empty.sv
│   ├── ...
├── README.md                 # You're reading it!
```

---

## How to Run

1. Compile using Xcelium:

   ```bash
   xrun -sv -f filelist.f -access +rwc
   ```

2. Run simulation:

   ```bash
   xrun -R
   ```

3. View coverage:

   ```bash
   xrun -covdump -covtest testname
   ```

---

## Notes

* Tested with 3 configurations:

  * `DEPTH=8`, `WIDTH=8`
  * `DEPTH=16`, `WIDTH=16`
  * `DEPTH=32`, `WIDTH=32`

* One known issue in **Reset FIFO Pointer Overflow Test**:

  * Full and empty flags misbehave under reset + writes.
  * Further debugging needed.

---

## Author

**M. Hamza Naeem**
Digital Design Verification Trainee
NUST Chip Design Centre (NCDC), Islamabad, Pakistan



