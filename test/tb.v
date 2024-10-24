`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // wire up the inputs and outputs
  reg clk;
  reg rst_n;
  reg ena;
  reg in_se;
  reg in_sc;
  reg [1:0] in_cfg;
  reg in_lb;
  reg [1:0] in_lbc;
  reg [7:0] ui_in;

  wire [7:0] uio_in;
  assign uio_in[0] = in_se;
  assign uio_in[1] = in_sc;
  assign uio_in[3:2] = in_cfg;
  assign uio_in[4] = in_lb;
  assign uio_in[6:5] = in_lbc;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
  wire out_sc = uio_out[7];

  // Replace tt_um_example with your module name:
  tt_um_htfab_rotfpga2 user_project (
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
