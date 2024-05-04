// Time unit is "ns"
`define create_clk(clk, tp, pol, del) \
logic clk; \
bit clk_gated_``clk; \
bit clk_gated_d_``clk; \
bit clk_polarity_``clk; \
//Default time period is 1.5ns \
real clk_time_period_``clk; \
initial \
begin \
  clk_time_period_``clk = ``tp; \
  #0; // End of step \
  clk = clk_polarity_``clk; \
  #del; // Delay in generating the clk \
  forever \
    begin \
      if (!clk_gated_``clk) \
       begin \
         #(clk_time_period_``clk/2) clk = ~clk;\
       end \
      else \
       begin \
         #clk_time_period_``clk; \
       end \
    end \
end \

// Create the clocks here
interface clk_reset_if;
timeunit 1ns;
logic clk;
reg reset_n;

// All clocks starts asynchronously
`create_clk(clk,1, 0, 0);

initial
begin
	reset_n = 0;
	#1 reset_n = 1;
end
endinterface  //END_OF_INTERFACE
