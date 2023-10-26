#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"
#include "vbuddy.cpp"     // include vbuddy code


#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main(int argc, char **argv, char **env) {
  int i;     // simulation clock count
  int clk;       // each clk cycle has two ticks for two edges

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vsinegen* top = new Vsinegen;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("sinegen.vcd");
 
  // init Vbuddy
  if (vbdOpen()!=1) return(-1);
  vbdHeader("L2T1: SigGen");
  //vbdSetMode(1);        // Flag mode set to one-shot

  // initialize simulation inputs
  top->clk = 1;
  top->rst = 0;
  top->en = 1;
  top->incr = 1;
  vbdSetMode(1);

  // run simulation for MAX_SIM_CYC clock cycles
  for (i=0; i<1000000; i++) {
    // dump variables into VCD file and toggle clock
    for (clk=0; clk<2; clk++) {
      tfp->dump (2*i+clk);
      top->clk = !top->clk;
      top->eval ();
    }
    
    if (vbdFlag()) {
        top->incr = vbdValue();
    }
    
    // plot ROM output and print cycle count
    vbdPlot(int (top->dout), 0, 255);
    vbdCycle(i+1);

    // either simulation finished, or 'q' is pressed
    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
        exit(0);                // ... exit if finish OR 'q' pressed on computer keyboard
  }

  vbdClose();    
  tfp->close(); 
  exit(0);
}