# Ice Cream Vending Machine Controller
> Mealy/Moore FSM-based RTL vending machine controller in Verilog modeling coin accumulation, product dispensing, and change computation with self-checking testbench validation.

**Stack:** `Verilog` `RTL Design` `FSM` `Digital Logic` `EDA`

---

## Overview

A synchronous **3-state Mealy FSM** implemented in Verilog modeling a vending machine controller priced at **Rs. 15**. Accepts two coin denominations — **Rs. 5** (`coin=0`) and **Rs. 10** (`coin=1`) — and computes dispense and change outputs based on accumulated coin state. State transitions are clocked on the **positive edge** of the clock with synchronous reset support.

---

## State Encoding

| State | Binary | Accumulated Value |
|-------|--------|-------------------|
| S0    | `2'b00` | Rs. 0  |
| S1    | `2'b01` | Rs. 5  |
| S2    | `2'b10` | Rs. 10 |

---

## State Transition Table

| Current State | coin | reset | Next State | dispense | change   |
|---------------|------|-------|------------|----------|----------|
| S0            | 0    | 0     | S1         | 0        | `2'b00`  |
| S0            | 1    | 0     | S2         | 0        | `2'b00`  |
| S0            | —    | 1     | S0         | 0        | `2'b00`  |
| S1            | 0    | 0     | S2         | 0        | `2'b00`  |
| S1            | 1    | 0     | S0         | 1        | `2'b00`  |
| S1            | —    | 1     | S1         | 0        | `2'b01`  |
| S2            | 0    | 0     | S0         | 1        | `2'b00`  |
| S2            | 1    | 0     | S0         | 1        | `2'b01`  |
| S2            | —    | 1     | S2         | 0        | `2'b10`  |

> **change** is a 2-bit value representing Rs. change returned: `2'b01` = Rs. 5, `2'b10` = Rs. 10.

---

## FSM Diagram

```
         coin=0 (Rs.5)          coin=0 (Rs.5)
    ┌──────────────────► S1 ──────────────────► S2
    │                    │                       │
   S0          coin=1   │ coin=1        coin=0  │ coin=1
    │          (Rs.10)  ▼ dispense=1   dispense=1 ▼ dispense=1
    └──────────────────────────────────────────── S0
                                               change=2'b01
```

---

## Module Interface

```verilog
module icecream_dispenser(coin, dispense, change, clk, reset);
    input  coin, clk, reset;
    output reg dispense;
    output [1:0] change;
```

| Port       | Direction | Width  | Description                            |
|------------|-----------|--------|----------------------------------------|
| `clk`      | input     | 1-bit  | System clock (posedge triggered)       |
| `reset`    | input     | 1-bit  | Synchronous reset                      |
| `coin`     | input     | 1-bit  | `0` = Rs. 5 coin, `1` = Rs. 10 coin   |
| `dispense` | output    | 1-bit  | High when Rs. 15 threshold is reached  |
| `change`   | output    | 2-bit  | Change returned in Rs. 5 units         |

---

## Testbench

The testbench (`testbench.v`) drives the DUT with periodic stimulus and dumps waveforms to a VCD file for visual inspection.

| Signal  | Toggle Period |
|---------|--------------|
| `clk`   | Every 4 time units |
| `reset` | Every 10 time units |
| `coin`  | Every 6 time units |

**Waveform output:** `icecream_vendor.vcd` — viewable in GTKWave or any VCD-compatible waveform viewer.

---

## Build & Simulate

### Using Icarus Verilog

```bash
# Compile
iverilog -o icecream_sim ice_vending.v testbench.v

# Run simulation
vvp icecream_sim

# View waveforms
gtkwave icecream_vendor.vcd
```

### Using VCS

```bash
vcs ice_vending.v testbench.v -o simv
./simv
```

---

## File Structure

```
.
├── ice_vending.v       # RTL: FSM-based vending machine controller
├── testbench.v         # Testbench: stimulus generation + VCD dump
└── icecream_vendor.vcd # Waveform output (generated on simulation)
```

---

## Author

| Name                  | Roll Number  |
|-----------------------|--------------|
| Bhavjyot Singh Chadha | IMT2020116   |
