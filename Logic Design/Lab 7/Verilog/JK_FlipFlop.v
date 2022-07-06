`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:44 05/02/2022 
// Design Name: 
// Module Name:    JK_FlipFlop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module JK_FlipFlop(
    input input_J,
    input input_K,
    input input_CLK,
	 input input_ENA,
    output output_QH,
    output output_QL
    );
	 
	wire [1:0] sel;
	reg [1:0] out;
	 
	assign sel = {input_J, input_K};
	assign output_QH = out[0];
	assign output_QL = out[1];
		
	always@(posedge input_CLK or posedge input_ENA)
		begin
			if (input_ENA == 1)
				begin
					out = 2'b10;
				end
			else
				begin
					case(sel)
						2'b00 : out = out;
						2'b01 : out = 2'b01;
						2'b10 : out = 2'b10;
						2'b11 : out = ~out;
					endcase
				end
		end

endmodule
