# Chapter 2 — Verilog Demonstration

This folder hosts the RTL referenced in `latex-guide/chapters/ch02_verilog_demonstration.tex`.

## Contents

- `rtl/design6_comb.v` – combinational baseline of the Design 6 adder.
- `rtl/design6_seq.v` – sequential resource-shared implementation used in the rest of the flow.
- `rtl/tb_design6.v` – simple testbench that pulses `start` and checks the summed result.

## Quick start

```bash
cd 01_Verilog_Demo
iverilog -g2012 -o build/design6 rtl/tb_design6.v rtl/design6_seq.v
vvp build/design6
```

Use `gtkwave design6.vcd` to view waveforms. The generated sequential RTL becomes the input for the synthesis recipe in Chapter 3.
