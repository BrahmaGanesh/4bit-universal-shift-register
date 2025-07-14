# 🔄 4-Bit Universal Shift Register (Verilog)

This project implements a 4-bit **Universal Shift Register** using Verilog HDL.  
It supports four fundamental operations controlled via a 2-bit `mode` input:

- **Hold**
- **Shift Right**
- **Shift Left**
- **Parallel Load**

---

## 📁 Project Structure

universal_shift_register/
├── rtl/
│ └── shift_register.v # Universal Shift Register RTL design
├── tb/
│ └── shift_register_tb.v # Verilog testbench
├── universal_tb # Simulation output binary (generated)
└── README.md # Project documentation


---

## ⚙️ Functionality

The 4-bit register operates based on the 2-bit control input `mode`:

| `mode` | Operation        | Description                           |
|--------|------------------|---------------------------------------|
| 00     | **Hold**         | Retains the current register value    |
| 01     | **Shift Right**  | Shifts right, inserts 0 at MSB        |
| 10     | **Shift Left**   | Shifts left, inserts 0 at LSB         |
| 11     | **Parallel Load**| Loads the 4-bit input `d` into the register |

- ✅ **Asynchronous Reset** (active-high): Clears the register to `0000`.

---

## 🔧 How to Simulate

> Requires [Icarus Verilog](http://iverilog.icarus.com/) installed and added to PATH.

### 1️⃣ Compile the design & testbench:

```bash
iverilog -o universal_tb rtl/shift_register.v tb/shift_register_tb.v

vvp universal_tb

Time=0 d=0000 mode=00 q=0000
Time=20 d=1010 mode=11 q=0000
Time=25 d=1010 mode=11 q=1010
Time=30 d=1010 mode=00 q=1010
Time=40 d=1010 mode=01 q=1010
Time=45 d=1010 mode=01 q=0101
Time=50 d=1010 mode=10 q=0101
Time=55 d=1010 mode=10 q=1010
Time=60 d=1010 mode=00 q=1010


📄 RTL Code Overview (shift_register.v)

module universal(
    input clk, reset,
    input [1:0] mode,
    input [3:0] d,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) q <= 4'b0000;
    else begin
        case (mode)
            2'b00: q <= q;                   // Hold
            2'b01: q <= {1'b0, q[3:1]};      // Shift Right
            2'b10: q <= {q[2:0], 1'b0 };      // Shift Left
            2'b11: q <= d;                   // Parallel Load
            default: q <= 4'b0000;
        endcase
    end
end
endmodule


🧪 Testbench Overview (shift_register_tb.v)
Generates a clock with a 10-time unit period.

Applies reset, then exercises each mode (load, hold, shift right, shift left).

Uses $monitor to observe real-time signal changes.

🧠 Key Concepts Practiced

RTL design using case statements
Asynchronous reset handling
Clocked behavior simulation
Register operations in digital design
Writing clean testbenches

🚀 Future Improvements
Add waveform output using $dumpfile("shift_register.vcd") and view with GTKWave.

Expand testbench with randomized stimulus and formal coverage bins.

Support bidirectional shifting or serial input/output.

📌 Author
Brahma Ganesh K
GitHub: BrahmaGanesh


---

