# Vending Machine

A simple Verilog implementation of a vending machine finite state machine (FSM) that accepts coins and dispenses a product when sufficient payment is received.

## Overview

This vending machine sells a single product priced at **15 Rupees**. It accepts two types of coins:
- 5 Rupees
- 10 Rupees

The machine provides change when overpayment occurs and maintains proper state transitions for coin accumulation.

## Features

- **Coin Acceptance**: Accepts 5Rs and 10Rs coins
- **Product Dispensing**: Dispenses product when 15Rs or more is inserted
- **Change Return**: Returns appropriate change for overpayment
- **State Management**: Uses finite state machine with 3 states (0Rs, 5Rs, 10Rs)
- **Synchronous Design**: All outputs are registered and synchronized to clock edges

## File Structure

```
├── README.md                           # This file
├── vending_machine.v                   # Main vending machine module
├── vending_machine_tb.v                # Testbench for simulation
├── vending_machine.vcd                 # Waveform dump file
├── vending_machine.v.out               # Compiled simulation output
├── vending_machine_tb.v.out            # Testbench simulation output
├── vending_machine_diagram.PDF         # State diagram
├── vending_machine_schematic.pdf       # Circuit schematic
└── vending_machine_waveform.png        # Waveform screenshot
```

## Module Interface

### Inputs
- `clk`: Clock signal
- `rst`: Asynchronous reset (active high)
- `in[1:0]`: Coin input
  - `2'b00`: No coin (0Rs)
  - `2'b01`: 5Rs coin
  - `2'b10`: 10Rs coin

### Outputs
- `out`: Product dispense signal (1 = dispense product)
- `change[1:0]`: Change output
  - `2'b00`: No change
  - `2'b01`: 5Rs change
  - `2'b10`: 10Rs change

## State Machine

The vending machine operates using a 3-state finite state machine:

- **S0 (2'b00)**: 0 Rupees collected
- **S1 (2'b01)**: 5 Rupees collected
- **S2 (2'b10)**: 10 Rupees collected

### State Transitions

| Current State | Input | Next State | Output | Change |
|---------------|-------|------------|--------|---------|
| S0 (0Rs) | 5Rs | S1 (5Rs) | 0 | 0 |
| S0 (0Rs) | 10Rs | S2 (10Rs) | 0 | 0 |
| S1 (5Rs) | 5Rs | S2 (10Rs) | 0 | 0 |
| S1 (5Rs) | 10Rs | S0 (0Rs) | 1 | 0 |
| S2 (10Rs) | 5Rs | S0 (0Rs) | 1 | 0 |
| S2 (10Rs) | 10Rs | S0 (0Rs) | 1 | 5Rs |

## How to Run

### Prerequisites
- Verilog simulator (iverilog, ModelSim, etc.)
- GTKWave for waveform viewing (optional)

### Simulation Steps

1. **Compile the design:**
   ```bash
   iverilog -o vending_machine_tb.v.out vending_machine_tb.v
   ```

2. **Run simulation:**
   ```bash
   ./vending_machine_tb.v.out
   ```

3. **View waveforms:**
   ```bash
   gtkwave vending_machine.vcd
   ```

## Test Cases

The testbench includes the following test scenarios:

1. **Insert 5Rs + 5Rs + 5Rs (15Rs total)**
   - Expected: Product dispensed, no change

2. **Insert 10Rs + 5Rs (15Rs total)**
   - Expected: Product dispensed, no change

3. **Insert 10Rs + 10Rs (20Rs total)**
   - Expected: Product dispensed, 5Rs change returned

## Timing Behavior

- All outputs are **registered** (synchronous)
- Product dispense signal appears **one clock cycle** after sufficient payment
- Change is provided simultaneously with product dispense
- Reset initializes all signals to known states (no 'X' values)

## Key Design Features

- **Synchronous Reset**: All registers properly initialized
- **Registered Outputs**: No combinational glitches
- **Proper FSM Design**: Clear state transitions and output logic
- **Comprehensive Testing**: Multiple payment scenarios covered

## License

This project is for educational purposes.
