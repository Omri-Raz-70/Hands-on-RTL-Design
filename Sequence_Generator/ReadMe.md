Moudle description:
Sequence Generator
Design the following sequence generator module:

0 → 1 → 1 → 1 → 2 → 2 → 3 → 4 → 5 → 7 → 9 → 12 → 16 → 21 → 28 → 37 → ...

Assume the sequence goes on forever until the circuit is reset. All the flops should be positive edge triggered with asynchronous resets (if any).

I have done this moudle succesfuly and create simple testbench file for it.

Here is an example of the Wave generator:
<img width="1840" height="115" alt="image" src="https://github.com/user-attachments/assets/55fd6065-4b56-4f0a-a8a0-d3a67e507825" />


In the screenshot we can see that seq_o gets the desired resault, and also set to zero when rst signal is 1.
