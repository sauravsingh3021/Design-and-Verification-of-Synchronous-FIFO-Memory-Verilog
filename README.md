# 🔁 Synchronous FIFO Memory Design and Verification
---
 ● Designed and implemented a parameterized synchronous FIFO (First-In-First-Out) memory to enable reliable data buffering in a
   single clock domain.
 ● Handled corner cases such as overflow, underflow, pointer wrap-around, full, and empty conditions.
 ● Developed a comprehensive Verilog testbench with 10+ directed test cases to validate functionality and robustness.
 ● Utilized circular pointer and parameterized depth and width to optimize resource utilization and scalability.
 ● Exposure: Verilog HDL, Siemens Questa, EDA Playground, Digital Design, FIFO.


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
├── design.sv # FIFO design module
├── testbench.sv # Testbench with 12 directed test cases
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
Data_width=8,
Depth=16


▶️ Running the Simulation
---

🖥 Siemens Questa/ Synopsys VCS
bash
Copy
Edit

vlog fifo.v tb_fifo.v
vsim tb_fifo +TESTCASE=1
run -all

Replace +TESTCASE=1 with any number between 1–12 to run a specific test case.

📚 Topics Covered
---

FIFO RTL design and parameterization

Read/write pointer logic with wrap-around

Count-based full/empty detection

Testbench construction with reusable tasks

Edge case handling (overflow, underflow, reset)


🚀 Future Enhancements
---

Implement an Asynchronous FIFO (dual clock domains)

Use Gray-coded pointers for metastability mitigation



