create_clock -name CRYSTAL_50M -period 20 -waveform {0 10} [get_ports {clk_in}]
derive_pll_clocks