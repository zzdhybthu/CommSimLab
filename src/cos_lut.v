module cos_lut (
    input wire [15:0] addr,
    output wire signed [7:0] cos_out  // 2^7 量化
);
    reg signed [7:0] cos[0:255];
    initial begin
        cos[0] = 8'd127;
        cos[1] = 8'd127;
        cos[2] = 8'd127;
        cos[3] = 8'd127;
        cos[4] = 8'd127;
        cos[5] = 8'd127;
        cos[6] = 8'd127;
        cos[7] = 8'd127;
        cos[8] = 8'd127;
        cos[9] = 8'd127;
        cos[10] = 8'd127;
        cos[11] = 8'd127;
        cos[12] = 8'd127;
        cos[13] = 8'd127;
        cos[14] = 8'd127;
        cos[15] = 8'd127;
        cos[16] = 8'd127;
        cos[17] = 8'd127;
        cos[18] = 8'd127;
        cos[19] = 8'd127;
        cos[20] = 8'd126;
        cos[21] = 8'd126;
        cos[22] = 8'd126;
        cos[23] = 8'd126;
        cos[24] = 8'd126;
        cos[25] = 8'd126;
        cos[26] = 8'd126;
        cos[27] = 8'd126;
        cos[28] = 8'd125;
        cos[29] = 8'd125;
        cos[30] = 8'd125;
        cos[31] = 8'd125;
        cos[32] = 8'd125;
        cos[33] = 8'd125;
        cos[34] = 8'd125;
        cos[35] = 8'd124;
        cos[36] = 8'd124;
        cos[37] = 8'd124;
        cos[38] = 8'd124;
        cos[39] = 8'd124;
        cos[40] = 8'd123;
        cos[41] = 8'd123;
        cos[42] = 8'd123;
        cos[43] = 8'd123;
        cos[44] = 8'd123;
        cos[45] = 8'd122;
        cos[46] = 8'd122;
        cos[47] = 8'd122;
        cos[48] = 8'd122;
        cos[49] = 8'd122;
        cos[50] = 8'd121;
        cos[51] = 8'd121;
        cos[52] = 8'd121;
        cos[53] = 8'd121;
        cos[54] = 8'd120;
        cos[55] = 8'd120;
        cos[56] = 8'd120;
        cos[57] = 8'd119;
        cos[58] = 8'd119;
        cos[59] = 8'd119;
        cos[60] = 8'd119;
        cos[61] = 8'd118;
        cos[62] = 8'd118;
        cos[63] = 8'd118;
        cos[64] = 8'd117;
        cos[65] = 8'd117;
        cos[66] = 8'd117;
        cos[67] = 8'd117;
        cos[68] = 8'd116;
        cos[69] = 8'd116;
        cos[70] = 8'd116;
        cos[71] = 8'd115;
        cos[72] = 8'd115;
        cos[73] = 8'd115;
        cos[74] = 8'd114;
        cos[75] = 8'd114;
        cos[76] = 8'd113;
        cos[77] = 8'd113;
        cos[78] = 8'd113;
        cos[79] = 8'd112;
        cos[80] = 8'd112;
        cos[81] = 8'd112;
        cos[82] = 8'd111;
        cos[83] = 8'd111;
        cos[84] = 8'd110;
        cos[85] = 8'd110;
        cos[86] = 8'd110;
        cos[87] = 8'd109;
        cos[88] = 8'd109;
        cos[89] = 8'd108;
        cos[90] = 8'd108;
        cos[91] = 8'd108;
        cos[92] = 8'd107;
        cos[93] = 8'd107;
        cos[94] = 8'd106;
        cos[95] = 8'd106;
        cos[96] = 8'd105;
        cos[97] = 8'd105;
        cos[98] = 8'd105;
        cos[99] = 8'd104;
        cos[100] = 8'd104;
        cos[101] = 8'd103;
        cos[102] = 8'd103;
        cos[103] = 8'd102;
        cos[104] = 8'd102;
        cos[105] = 8'd101;
        cos[106] = 8'd101;
        cos[107] = 8'd100;
        cos[108] = 8'd100;
        cos[109] = 8'd99;
        cos[110] = 8'd99;
        cos[111] = 8'd98;
        cos[112] = 8'd98;
        cos[113] = 8'd97;
        cos[114] = 8'd97;
        cos[115] = 8'd96;
        cos[116] = 8'd96;
        cos[117] = 8'd95;
        cos[118] = 8'd95;
        cos[119] = 8'd94;
        cos[120] = 8'd94;
        cos[121] = 8'd93;
        cos[122] = 8'd93;
        cos[123] = 8'd92;
        cos[124] = 8'd92;
        cos[125] = 8'd91;
        cos[126] = 8'd91;
        cos[127] = 8'd90;
        cos[128] = 8'd89;
        cos[129] = 8'd89;
        cos[130] = 8'd88;
        cos[131] = 8'd88;
        cos[132] = 8'd87;
        cos[133] = 8'd87;
        cos[134] = 8'd86;
        cos[135] = 8'd85;
        cos[136] = 8'd85;
        cos[137] = 8'd84;
        cos[138] = 8'd84;
        cos[139] = 8'd83;
        cos[140] = 8'd83;
        cos[141] = 8'd82;
        cos[142] = 8'd81;
        cos[143] = 8'd81;
        cos[144] = 8'd80;
        cos[145] = 8'd79;
        cos[146] = 8'd79;
        cos[147] = 8'd78;
        cos[148] = 8'd78;
        cos[149] = 8'd77;
        cos[150] = 8'd76;
        cos[151] = 8'd76;
        cos[152] = 8'd75;
        cos[153] = 8'd74;
        cos[154] = 8'd74;
        cos[155] = 8'd73;
        cos[156] = 8'd73;
        cos[157] = 8'd72;
        cos[158] = 8'd71;
        cos[159] = 8'd71;
        cos[160] = 8'd70;
        cos[161] = 8'd69;
        cos[162] = 8'd69;
        cos[163] = 8'd68;
        cos[164] = 8'd67;
        cos[165] = 8'd67;
        cos[166] = 8'd66;
        cos[167] = 8'd65;
        cos[168] = 8'd65;
        cos[169] = 8'd64;
        cos[170] = 8'd63;
        cos[171] = 8'd63;
        cos[172] = 8'd62;
        cos[173] = 8'd61;
        cos[174] = 8'd61;
        cos[175] = 8'd60;
        cos[176] = 8'd59;
        cos[177] = 8'd58;
        cos[178] = 8'd58;
        cos[179] = 8'd57;
        cos[180] = 8'd56;
        cos[181] = 8'd56;
        cos[182] = 8'd55;
        cos[183] = 8'd54;
        cos[184] = 8'd54;
        cos[185] = 8'd53;
        cos[186] = 8'd52;
        cos[187] = 8'd51;
        cos[188] = 8'd51;
        cos[189] = 8'd50;
        cos[190] = 8'd49;
        cos[191] = 8'd48;
        cos[192] = 8'd48;
        cos[193] = 8'd47;
        cos[194] = 8'd46;
        cos[195] = 8'd46;
        cos[196] = 8'd45;
        cos[197] = 8'd44;
        cos[198] = 8'd43;
        cos[199] = 8'd43;
        cos[200] = 8'd42;
        cos[201] = 8'd41;
        cos[202] = 8'd40;
        cos[203] = 8'd40;
        cos[204] = 8'd39;
        cos[205] = 8'd38;
        cos[206] = 8'd37;
        cos[207] = 8'd37;
        cos[208] = 8'd36;
        cos[209] = 8'd35;
        cos[210] = 8'd34;
        cos[211] = 8'd34;
        cos[212] = 8'd33;
        cos[213] = 8'd32;
        cos[214] = 8'd31;
        cos[215] = 8'd31;
        cos[216] = 8'd30;
        cos[217] = 8'd29;
        cos[218] = 8'd28;
        cos[219] = 8'd28;
        cos[220] = 8'd27;
        cos[221] = 8'd26;
        cos[222] = 8'd25;
        cos[223] = 8'd24;
        cos[224] = 8'd24;
        cos[225] = 8'd23;
        cos[226] = 8'd22;
        cos[227] = 8'd21;
        cos[228] = 8'd21;
        cos[229] = 8'd20;
        cos[230] = 8'd19;
        cos[231] = 8'd18;
        cos[232] = 8'd18;
        cos[233] = 8'd17;
        cos[234] = 8'd16;
        cos[235] = 8'd15;
        cos[236] = 8'd14;
        cos[237] = 8'd14;
        cos[238] = 8'd13;
        cos[239] = 8'd12;
        cos[240] = 8'd11;
        cos[241] = 8'd10;
        cos[242] = 8'd10;
        cos[243] = 8'd9;
        cos[244] = 8'd8;
        cos[245] = 8'd7;
        cos[246] = 8'd7;
        cos[247] = 8'd6;
        cos[248] = 8'd5;
        cos[249] = 8'd4;
        cos[250] = 8'd3;
        cos[251] = 8'd3;
        cos[252] = 8'd2;
        cos[253] = 8'd1;
        cos[254] = 8'd0;
        cos[255] = 8'd0;
    end

    assign cos_out = cos[addr[7:0]];

endmodule