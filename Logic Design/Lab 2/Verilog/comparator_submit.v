// Verilog test fixture created from schematic /csehome/sagit25/Comparator/comparator.sch - Mon Mar 28 19:40:23 2022

`timescale 1ns / 1ps

module comparator_comparator_sch_tb();

// Inputs
   reg A;
   reg C;
   reg D;
   reg B;

// Output
   wire LT;
   wire EQ;
   wire GT;

// Bidirs
	integer i;

// Instantiate the UUT
   comparator UUT (
		.A(A), 
		.C(C), 
		.D(D), 
		.LT(LT), 
		.B(B), 
		.EQ(EQ), 
		.GT(GT)
   );
// Initialize Inputs
	initial begin
		A = 0;
		C = 0;
		D = 0;
		B = 0;
		
		for (i = 0; i < 16; i = i+1)
		begin
			if(i < 8) begin A = 0; end else begin A = 1; end
			if(i < 4 || (8 <= i && i < 12)) begin B = 0; end else begin B = 1; end
			if((i / 2) % 2 == 1) begin C = 1; end else begin C = 0; end
			if(i % 2 == 1) begin D = 1; end else begin D = 0; end
			#50;
		end	
	end
endmodule
