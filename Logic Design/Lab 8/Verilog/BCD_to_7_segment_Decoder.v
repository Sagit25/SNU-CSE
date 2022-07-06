`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:16 05/16/2022 
// Design Name: 
// Module Name:    BCD_to_7_segment_Decoder 
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
module BCD_to_7_segment_Decoder(
    input [1:0] input_BCD,
    output [6:0] output_segment1, 
	 output [6:0] output_segment2
    );
	 
	 reg [6:0] out1;
	 reg [6:0] out2;
	 
	 assign output_segment1 = out1;
	 assign output_segment2 = out2;
	 
	 always@(input_BCD) begin
		case(input_BCD)
			2'b00 : begin
						out1 = 7'b1111110;
						out2 = 7'b1111110;
					  end
			2'b01 : begin
						out1 = 7'b1111110;
						out2 = 7'b1011011;
					  end
			2'b10 : begin
						out1 = 7'b0110000;
						out2 = 7'b1111110;
					  end
			2'b11 : begin
						out1 = 7'b0110000;
						out2 = 7'b1011011;
					  end
			default: begin
							out1 = 7'b0000000;
							out2 = 7'b0000000;
						end
		endcase
	 end

endmodule
