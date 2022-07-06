`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:34:19 04/11/2022 
// Design Name: 
// Module Name:    BCD_structural 
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
module BCD_structural(
    output A,
    output B,
    output C,
    output D,
    output E,
    output F,
    output G,
    input I0,
    input I1,
    input I2,
    input I3
    );
	 
			wire i0, i1, i2, i3;
			wire I0I1, I0i1, I0I2, I0i2, I0I3, I0i3, i0I1, i0i1, i0I2, i0i2, i0I3, i0i3, I1I2, I1i2, I1I3, I1i3, i1I2, i1i2, i1I3, i1i3, I2I3, I2i3, i2I3, i2i3, I0I1I2, I0I1i2, I0I1I3, I0I1i3, I0i1I2, I0i1i2, I0i1I3, I0i1i3, I0I2I3, I0I2i3, I0i2I3, I0i2i3, i0I1I2, i0I1i2, i0I1I3, i0I1i3, i0i1I2, i0i1i2, i0i1I3, i0i1i3, i0I2I3, i0I2i3, i0i2I3, i0i2i3, I1I2I3, I1I2i3, I1i2I3, I1i2i3, i1I2I3, i1I2i3, i1i2I3, i1i2i3, I0I1I2I3, I0I1I2i3, I0I1i2I3, I0I1i2i3, I0i1I2I3, I0i1I2i3, I0i1i2I3, I0i1i2i3, i0I1I2I3, i0I1I2i3, i0I1i2I3, i0I1i2i3, i0i1I2I3, i0i1I2i3, i0i1i2I3, i0i1i2i3;
			
			not T1 (i0, I0);
			not T2 (i1, I1);
			not T3 (i2, I2);
			not T4 (i3, I3);
			
			and T5 (I0I1, I0, I1);
			and T6 (I0i1, I0, i1);
			and T7 (I0I2, I0, I2);
			and T8 (I0i2, I0, i2);
			and T9 (I0I3, I0, I3);
			and T10 (I0i3, I0, i3);
			and T11 (i0I1, i0, I1);
			and T12 (i0i1, i0, i1);
			and T13 (i0I2, i0, I2);
			and T14 (i0i2, i0, i2);
			and T15 (i0I3, i0, I3);
			and T16 (i0i3, i0, i3);
			and T17 (I1I2, I1, I2);
			and T18 (I1i2, I1, i2);
			and T19 (I1I3, I1, I3);
			and T20 (I1i3, I1, i3);
			and T21 (i1I2, i1, I2);
			and T22 (i1i2, i1, i2);
			and T23 (i1I3, i1, I3);
			and T24 (i1i3, i1, i3);
			and T25 (I2I3, I2, I3);
			and T26 (I2i3, I2, i3);
			and T27 (i2I3, i2, I3);
			and T28 (i2i3, i2, i3);
			and T29 (I0I1I2, I0, I1, I2);
			and T30 (I0I1i2, I0, I1, i2);
			and T31 (I0I1I3, I0, I1, I3);
			and T32 (I0I1i3, I0, I1, i3);
			and T33 (I0i1I2, I0, i1, I2);
			and T34 (I0i1i2, I0, i1, i2);
			and T35 (I0i1I3, I0, i1, I3);
			and T36 (I0i1i3, I0, i1, i3);
			and T37 (I0I2I3, I0, I2, I3);
			and T38 (I0I2i3, I0, I2, i3);
			and T39 (I0i2I3, I0, i2, I3);
			and T40 (I0i2i3, I0, i2, i3);
			and T41 (i0I1I2, i0, I1, I2);
			and T42 (i0I1i2, i0, I1, i2);
			and T43 (i0I1I3, i0, I1, I3);
			and T44 (i0I1i3, i0, I1, i3);
			and T45 (i0i1I2, i0, i1, I2);
			and T46 (i0i1i2, i0, i1, i2);
			and T47 (i0i1I3, i0, i1, I3);
			and T48 (i0i1i3, i0, i1, i3);
			and T49 (i0I2I3, i0, I2, I3);
			and T50 (i0I2i3, i0, I2, i3);
			and T51 (i0i2I3, i0, i2, I3);
			and T52 (i0i2i3, i0, i2, i3);
			and T53 (I1I2I3, I1, I2, I3);
			and T54 (I1I2i3, I1, I2, i3);
			and T55 (I1i2I3, I1, i2, I3);
			and T56 (I1i2i3, I1, i2, i3);
			and T57 (i1I2I3, i1, I2, I3);
			and T58 (i1I2i3, i1, I2, i3);
			and T59 (i1i2I3, i1, i2, I3);
			and T60 (i1i2i3, i1, i2, i3);
			and T61 (I0I1I2I3, I0, I1, I2, I3);
			and T62 (I0I1I2i3, I0, I1, I2, i3);
			and T63 (I0I1i2I3, I0, I1, i2, I3);
			and T64 (I0I1i2i3, I0, I1, i2, i3);
			and T65 (I0i1I2I3, I0, i1, I2, I3);
			and T66 (I0i1I2i3, I0, i1, I2, i3);
			and T67 (I0i1i2I3, I0, i1, i2, I3);
			and T68 (I0i1i2i3, I0, i1, i2, i3);
			and T69 (i0I1I2I3, i0, I1, I2, I3);
			and T70 (i0I1I2i3, i0, I1, I2, i3);
			and T71 (i0I1i2I3, i0, I1, i2, I3);
			and T72 (i0I1i2i3, i0, I1, i2, i3);
			and T73 (i0i1I2I3, i0, i1, I2, I3);
			and T74 (i0i1I2i3, i0, i1, I2, i3);
			and T75 (i0i1i2I3, i0, i1, i2, I3);
			and T76 (i0i1i2i3, i0, i1, i2, i3);
			
			or T1001 (A, I0, I1I3, I2, i1i3);
			or T1002 (B, i2i3, I2I3, i1);
			or T1003 (C, I1, i2, I3);
			or T1004 (D, I0, I2i3, i1I2, i1i3, I1i2I3);
			or T1005 (E, i1i3, I2i3);
			or T1006 (F, I0, I1, i2i3);
			or T1007 (G, I0, I2i3, I1i2, i1I2);
			
endmodule
