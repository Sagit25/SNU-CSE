`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:18 05/16/2022 
// Design Name: 
// Module Name:    Frequency_Divider 
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
module Frequency_Divider(
    input input_CLK,
    input input_ENA,
    output output_CLK
    );
		
    reg [31:0] cnt;
    reg out;
    assign output_CLK = out;
	 
    always@(posedge input_CLK or posedge input_ENA) begin
        if(input_ENA) begin
            cnt <= 32'd0;
            out <= 1'b0;
        end
        else if(cnt == 32'd25000000) begin
            cnt <= 32'd0;
            out <= ~out;
        end 
        else begin
            cnt <= cnt + 1;
        end
    end
	 
endmodule
