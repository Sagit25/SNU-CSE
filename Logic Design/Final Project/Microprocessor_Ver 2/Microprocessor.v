module Microprocessor(
    input input_Clock,
    input input_Reset,
    input [7:0] input_Instruction,
    output [13:0] output_Display,
    output [7:0] output_Address
    );
     
     reg [7:0] next;
     
     reg [1:0] register[3:0];
     reg [7:0] memory[31:0];
     
     reg [13:0] result;
     
     assign output_Address = next;
     assign output_Display = result;
     
     integer data;
     
     always@(posedge input_Clock or posedge input_Reset) begin
            if(input_Reset) begin
                next = 8'b00000000;
                register[0] = 8'b00000000;
                register[1] = 8'b00000000;
                register[2] = 8'b00000000;
                register[3] = 8'b00000000;
                memory[0] = 8'b00000000;
                memory[1] = 8'b00000001;
                memory[2] = 8'b00000010;
                memory[3] = 8'b00000011;
                memory[4] = 8'b00000100;
                memory[5] = 8'b00000101;
                memory[6] = 8'b00000110;
                memory[7] = 8'b00000111;
                memory[8] = 8'b00001000;
                memory[9] = 8'b00001001;
                memory[10] = 8'b00001010;
                memory[11] = 8'b00001011;
                memory[12] = 8'b00001100;
                memory[13] = 8'b00001101;
                memory[14] = 8'b00001110;
                memory[15] = 8'b00001111;
                memory[16] = 8'b00000000;
                memory[17] = 8'b11111111;
                memory[18] = 8'b11111110;
                memory[19] = 8'b11111101;
                memory[20] = 8'b11111100;
                memory[21] = 8'b11111011;
                memory[22] = 8'b11111010;
                memory[23] = 8'b11111001;
                memory[24] = 8'b11111000;
                memory[25] = 8'b11110111;
                memory[26] = 8'b11110110;
                memory[27] = 8'b11110101;
                memory[28] = 8'b11110100;
                memory[29] = 8'b11110011;
                memory[30] = 8'b11110010;
                memory[31] = 8'b11110001;
            end
            else if(input_Instruction[7:6] == 2'b11) begin
                // result = 8'b00000000;
                next = next + input_Instruction[1:0] + 1;
            end
            else begin
                next = next + 1;
                if(input_Instruction[7:6] == 2'b10) begin
                    // result = 8'b00000000;
                    memory[register[input_Instruction[5:4]] + input_Instruction[1:0]] = register[input_Instruction[3:2]];
                end
                else if(input_Instruction[7:6] == 2'b00) begin
                    result = register[input_Instruction[5:4]] + register[input_Instruction[3:2]];
                    register[input_Instruction[1:0]] = result;
                end
                else if(input_Instruction[7:6] == 2'b01) begin
                    result = memory[register[input_Instruction[5:4]] + input_Instruction[1:0]];
                    register[input_Instruction[3:2]] = result;
                end
            end
     end

endmodule
