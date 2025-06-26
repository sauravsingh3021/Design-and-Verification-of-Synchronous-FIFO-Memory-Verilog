# 🔁 Synchronous FIFO Memory Design and Verification

This project implements a **parameterized synchronous FIFO (First-In-First-Out)** memory module using Verilog, along with a **comprehensive testbench** to validate its functionality across 12 directed test cases.

---

## 📌 Overview

A FIFO memory is a critical digital design component used to buffer data between modules. This Verilog-based implementation supports configurable width and depth, providing robust handling of various corner cases including overflow, underflow, and pointer wrap-around.

---

## 🧠 Features

- ✅ Fully parameterized (`DATA_WIDTH`, `DEPTH`)
- ✅ Operates entirely within a single clock domain
- ✅ Circular pointer management
- ✅ Accurate `full` and `empty` flag detection
- ✅ Handles:
  - Overflow
  - Underflow
  - Reset behavior
  - Simultaneous read/write
  - Pointer wrap-around

---

## 🗂️ File Structure


---
.
├── fifo.v # FIFO design module
├── tb_fifo.v # Testbench with 12 directed test cases
├── dump.vcd # Optional waveform file
├── README.md # Project documentation

## 🧪 Testbench

The testbench (`tb_fifo.v`) includes **12 directed test cases** covering all functional and corner scenarios:

| Test Case | Description                          |
|-----------|--------------------------------------|
| TC_01     | Write operation                      |
| TC_02     | Read operation                       |
| TC_03     | Full condition check                 |
| TC_04     | Empty condition check                |
| TC_05     | Single write and read                |
| TC_06     | Multiple writes                      |
| TC_07     | Multiple reads                       |
| TC_08     | Reset clears FIFO                    |
| TC_09     | Overflow handling                    |
| TC_10     | Underflow handling                   |
| TC_11     | Pointer wrap-around functionality    |
| TC_12     | Simultaneous read and write          |

---

## 🛠 Parameters

You can easily modify the FIFO's configuration:

```verilog
parameter DATA_WIDTH = 8;
parameter DEPTH = 16;

▶️ Running the Simulation
🖥 Using ModelSim/QuestaSim
bash
Copy
Edit

vlog fifo.v tb_fifo.v
vsim tb_fifo +TESTCASE=1
run -all

Replace +TESTCASE=1 with any number between 1–12 to run a specific test case.

🌐 Using EDA Playground
Go to EDA Playground

Paste the fifo.v and tb_fifo.v code into the appropriate sections

Select Questa Advanced (2020.4) as the simulator

Add simulation option: +TESTCASE=1

Click Run to simulate and view results

📈 Viewing Waveforms (Optional)
If waveform dumping is enabled via:

verilog
Copy
Edit
$dumpfile("dump.vcd");
$dumpvars(0, tb_fifo);
You can use GTKWave to view the waveform:

bash
Copy
Edit
gtkwave dump.vcd
📚 Topics Covered
FIFO RTL design and parameterization

Read/write pointer logic with wrap-around

Count-based full/empty detection

Testbench construction with reusable tasks

Edge case handling (overflow, underflow, reset)

🚀 Future Enhancements
Implement an Asynchronous FIFO (dual clock domains)

Use Gray-coded pointers for metastability mitigation

Add AXI/AXIS FIFO wrapper for SoC integration

👨‍💻 Author
Your Name
Digital Design & Verification Enthusiast
📧 your.email@example.com
🔗 GitHub


