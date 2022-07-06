`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:15:29 05/16/2022 
// Design Name: 
// Module Name:    Core_Logic 
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
module Core_Logic(
    input Ni,
    input Di,
    inout [1:0] Q,
	 output open,
    input reset,
    input clk
    );
	 
	 reg [1:0] S;
	 reg op;
	 assign Q = S;
	 assign open = op;
	 
	 always @(posedge clk or posedge reset) begin
		if (reset != 0) begin
			S = 2'b00;
			op = 0;
		end
		else begin
			case(S)
				2'b00 : if (Ni != 0) begin 
							S = 2'b01;
							op = 0;						
						  end
						  else if (Di != 0) begin
							S = 2'b10;
							op = 0;
						  end
						  else begin
							S = 2'b00;
							op = 0;
						  end
				2'b01 : if (Ni != 0) begin 
							S = 2'b10; 
							op = 0;
						  end
						  else if (Di != 0) begin
							S = 2'b11;
							op = 1;
						  end
						  else begin
							S = 2'b01;
							op = 0;
						  end
				2'b10 : if (Ni != 0) begin 
							S = 2'b11; 
							op = 1;
						  end
						  else if (Di != 0) begin
							S = 2'b11;
							op = 1;
						  end
						  else begin
							S = 2'b10;
							op = 0;
						  end
				2'b11 : if (Ni != 0) begin 
							S = 2'b11; 
							op = 1;
						  end
						  else if (Di != 0) begin
							S = 2'b11;
							op = 1;
						  end
						  else begin
							S = 2'b11;
							op = 1;
						  end
			endcase
		end
	 end

endmodule
