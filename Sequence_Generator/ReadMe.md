
##Sequence Generator

This project implements a digital sequence generator using Verilog/SystemVerilog.

**The Sequence:**
`0 → 1 → 1 → 1 → 2 → 2 → 3 → 4 → 5 → 7 → 9 → 12 → 16 → 21 → 28 → 37 ...`

## Specifications
* **Logic:** The sequence generates indefinitely until interrupted.
* **Clocking:** Positive edge triggered.
* **Reset:** Asynchronous Reset.
    * When `rst` is asserted (1), the output `seq_o` resets to `0`.

I have done this moudle succesfuly and create simple testbench file for it.

The waveform below demonstrates the correct operation. You can see `seq_o` updating at every clock edge  and resetting to `0` when the `rst` signal goes high.
<img width="1838" height="104" alt="image" src="https://github.com/user-attachments/assets/025ba47a-9e3b-4fc3-a238-ccac0189ec87" />

