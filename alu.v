module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
 
	
   // YOUR CODE HERE //
	wire [31:0] dataBWire, sum, andresult, orresult, sllresult, sraresult;
	//cin for subtract also op00001
	wire cin, op00000, op00010, op00011, op00100, op00101, tempover, subandsame;
	and and0(op00000,~ctrl_ALUopcode[0],~ctrl_ALUopcode[1],~ctrl_ALUopcode[2],~ctrl_ALUopcode[3],~ctrl_ALUopcode[4]); 
	and and1(cin,ctrl_ALUopcode[0],~ctrl_ALUopcode[1],~ctrl_ALUopcode[2],~ctrl_ALUopcode[3],~ctrl_ALUopcode[4]);
	and and2(op00010,~ctrl_ALUopcode[0],ctrl_ALUopcode[1],~ctrl_ALUopcode[2],~ctrl_ALUopcode[3],~ctrl_ALUopcode[4]);
	and and3(op00011,ctrl_ALUopcode[0],ctrl_ALUopcode[1],~ctrl_ALUopcode[2],~ctrl_ALUopcode[3],~ctrl_ALUopcode[4]);
	and and4(op00100,~ctrl_ALUopcode[0],~ctrl_ALUopcode[1],ctrl_ALUopcode[2],~ctrl_ALUopcode[3],~ctrl_ALUopcode[4]);
	and and5(op00101,ctrl_ALUopcode[0],~ctrl_ALUopcode[1],ctrl_ALUopcode[2],~ctrl_ALUopcode[3],~ctrl_ALUopcode[4]);
	assign dataBWire = cin ? ~data_operandB: data_operandB;
	
	partialcarryLookAdder myadder(data_operandA, dataBWire, cin, sum, tempover);
	or or0(isNotEqual, sum[0], sum[1], sum[2], sum[3], sum[4], sum[5], sum[6], sum[7], sum[8], sum[9], sum[10], sum[11], sum[12], sum[13], sum[14], sum[15], sum[16], sum[17], sum[18], sum[19], sum[20], sum[21], sum[22], sum[23], sum[24], sum[25], sum[26], sum[27], sum[28], sum[29], sum[30], sum[31]);
	and and8(subandsame, cin, ~isNotEqual);
	//assign sum = subandsame ? 32'b0 : tempsum;
	
	wire temp, bothpos, bothposnegflag;
   and and9(bothpos, ~data_operandA[31], ~data_operandA[31]);
	and and7(bothposnegflag, bothpos, sum[31]);

	
	//assign isLessThan = sum[31];
	//or or6(isLessThan, sum[31], ~subandsame);
	wire temp111;
	and and112(temp111, overflow, ~sum[31]);
	or or111(isLessThan, sum[31], temp111);
	wire cinnew;
	assign cinnew = subandsame ? 1'b0 : cin;
	
	bitAnd bitwiseAnd(andresult, data_operandA, data_operandB);
	
	bitOr bitwiseOr(orresult, data_operandA, data_operandB);
	
	sll sll1(sllresult, data_operandA, ctrl_shiftamt);
	
	sra sra1(sraresult, data_operandA, ctrl_shiftamt);
	
	wire temptempover;
	or or1(temptempover, bothposnegflag, tempover);
	and and10(overflow, temptempover, 	~subandsame);
	
	assign data_result = subandsame ? 32'b0: (op00000? sum: (cinnew?sum: (op00010? andresult: (op00011? orresult: (op00100? sllresult: (op00101? sraresult: sraresult))))));
endmodule


module sra(out, in, amt);
	input [31:0] in;
	input [4:0] amt;
	output [31:0] out;
	
	wire sigbit;
	assign sigbit = in[31];
	
	//muxcolrow only 31 bits, most significant bit in arithmetic shift is equal
	wire from0[31:0], from1[31:0], from2[31:0], from3[31:0];
	
	//col0
	mux2to1 mux00(from0[0], in[0], in[1], amt[0]);
	mux2to1 mux01(from0[1], in[1], in[2], amt[0]);
	mux2to1 mux02(from0[2], in[2], in[3], amt[0]);
	mux2to1 mux03(from0[3], in[3], in[4], amt[0]);
	mux2to1 mux04(from0[4], in[4], in[5], amt[0]);
	mux2to1 mux05(from0[5], in[5], in[6], amt[0]);
	mux2to1 mux06(from0[6], in[6], in[7], amt[0]);
	mux2to1 mux07(from0[7], in[7], in[8], amt[0]);
	mux2to1 mux08(from0[8], in[8], in[9], amt[0]);
	mux2to1 mux09(from0[9], in[9], in[10], amt[0]);
	mux2to1 mux010(from0[10], in[10], in[11], amt[0]);
	mux2to1 mux011(from0[11], in[11], in[12], amt[0]);
	mux2to1 mux012(from0[12], in[12], in[13], amt[0]);
	mux2to1 mux013(from0[13], in[13], in[14], amt[0]);
	mux2to1 mux014(from0[14], in[14], in[15], amt[0]);
	mux2to1 mux015(from0[15], in[15], in[16], amt[0]);
	mux2to1 mux016(from0[16], in[16], in[17], amt[0]);
	mux2to1 mux017(from0[17], in[17], in[18], amt[0]);
	mux2to1 mux018(from0[18], in[18], in[19], amt[0]);
	mux2to1 mux019(from0[19], in[19], in[20], amt[0]);
	mux2to1 mux020(from0[20], in[20], in[21], amt[0]);
	mux2to1 mux021(from0[21], in[21], in[22], amt[0]);
	mux2to1 mux022(from0[22], in[22], in[23], amt[0]);
	mux2to1 mux023(from0[23], in[23], in[24], amt[0]);
	mux2to1 mux024(from0[24], in[24], in[25], amt[0]);
	mux2to1 mux025(from0[25], in[25], in[26], amt[0]);
	mux2to1 mux026(from0[26], in[26], in[27], amt[0]);
	mux2to1 mux027(from0[27], in[27], in[28], amt[0]);
	mux2to1 mux028(from0[28], in[28], in[29], amt[0]);
	mux2to1 mux029(from0[29], in[29], in[30], amt[0]);
	mux2to1 mux030(from0[30], in[30], in[31], amt[0]);
	mux2to1 mux031(from0[31], in[31], sigbit, amt[0]);
		
	//col1
	mux2to1 mux10(from1[0], from0[0], from0[2], amt[1]);
	mux2to1 mux11(from1[1], from0[1], from0[3], amt[1]);
	mux2to1 mux12(from1[2], from0[2], from0[4], amt[1]);
	mux2to1 mux13(from1[3], from0[3], from0[5], amt[1]);
	mux2to1 mux14(from1[4], from0[4], from0[6], amt[1]);
	mux2to1 mux15(from1[5], from0[5], from0[7], amt[1]);
	mux2to1 mux16(from1[6], from0[6], from0[8], amt[1]);
	mux2to1 mux17(from1[7], from0[7], from0[9], amt[1]);
	mux2to1 mux18(from1[8], from0[8], from0[10], amt[1]);
	mux2to1 mux19(from1[9], from0[9], from0[11], amt[1]);
	mux2to1 mux110(from1[10], from0[10], from0[12], amt[1]);
	mux2to1 mux111(from1[11], from0[11], from0[13], amt[1]);
	mux2to1 mux112(from1[12], from0[12], from0[14], amt[1]);
	mux2to1 mux113(from1[13], from0[13], from0[15], amt[1]);
	mux2to1 mux114(from1[14], from0[14], from0[16], amt[1]);
	mux2to1 mux115(from1[15], from0[15], from0[17], amt[1]);
	mux2to1 mux116(from1[16], from0[16], from0[18], amt[1]);
	mux2to1 mux117(from1[17], from0[17], from0[19], amt[1]);
	mux2to1 mux118(from1[18], from0[18], from0[20], amt[1]);
	mux2to1 mux119(from1[19], from0[19], from0[21], amt[1]);
	mux2to1 mux120(from1[20], from0[20], from0[22], amt[1]);
	mux2to1 mux121(from1[21], from0[21], from0[23], amt[1]);
	mux2to1 mux122(from1[22], from0[22], from0[24], amt[1]);
	mux2to1 mux123(from1[23], from0[23], from0[25], amt[1]);
	mux2to1 mux124(from1[24], from0[24], from0[26], amt[1]);
	mux2to1 mux125(from1[25], from0[25], from0[27], amt[1]);
	mux2to1 mux126(from1[26], from0[26], from0[28], amt[1]);
	mux2to1 mux127(from1[27], from0[27], from0[29], amt[1]);
	mux2to1 mux128(from1[28], from0[28], from0[30], amt[1]);
	mux2to1 mux129(from1[29], from0[29], from0[31], amt[1]);
	mux2to1 mux130(from1[30], from0[30], sigbit, amt[1]);
	mux2to1 mux131(from1[31], from0[31], sigbit, amt[1]);
	
	//col2
	mux2to1 mux20(from2[0], from1[0], from1[4], amt[2]);
	mux2to1 mux21(from2[1], from1[1], from1[5], amt[2]);
	mux2to1 mux22(from2[2], from1[2], from1[6], amt[2]);
	mux2to1 mux23(from2[3], from1[3], from1[7], amt[2]);
	mux2to1 mux24(from2[4], from1[4], from1[8], amt[2]);
	mux2to1 mux25(from2[5], from1[5], from1[9], amt[2]);
	mux2to1 mux26(from2[6], from1[6], from1[10], amt[2]);
	mux2to1 mux27(from2[7], from1[7], from1[11], amt[2]);
	mux2to1 mux28(from2[8], from1[8], from1[12], amt[2]);
	mux2to1 mux29(from2[9], from1[9], from1[13], amt[2]);
	mux2to1 mux210(from2[10], from1[10], from1[14], amt[2]);
	mux2to1 mux211(from2[11], from1[11], from1[15], amt[2]);
	mux2to1 mux212(from2[12], from1[12], from1[16], amt[2]);
	mux2to1 mux213(from2[13], from1[13], from1[17], amt[2]);
	mux2to1 mux214(from2[14], from1[14], from1[18], amt[2]);
	mux2to1 mux215(from2[15], from1[15], from1[19], amt[2]);
	mux2to1 mux216(from2[16], from1[16], from1[20], amt[2]);
	mux2to1 mux217(from2[17], from1[17], from1[21], amt[2]);
	mux2to1 mux218(from2[18], from1[18], from1[22], amt[2]);
	mux2to1 mux219(from2[19], from1[19], from1[23], amt[2]);
	mux2to1 mux220(from2[20], from1[20], from1[24], amt[2]);
	mux2to1 mux221(from2[21], from1[21], from1[25], amt[2]);
	mux2to1 mux222(from2[22], from1[22], from1[26], amt[2]);
	mux2to1 mux223(from2[23], from1[23], from1[27], amt[2]);
	mux2to1 mux224(from2[24], from1[24], from1[28], amt[2]);
	mux2to1 mux225(from2[25], from1[25], from1[29], amt[2]);
	mux2to1 mux226(from2[26], from1[26], from1[30], amt[2]);
	mux2to1 mux227(from2[27], from1[27], from1[31], amt[2]);
	mux2to1 mux228(from2[28], from1[28], sigbit, amt[2]);
	mux2to1 mux229(from2[29], from1[29], sigbit, amt[2]);
	mux2to1 mux230(from2[30], from1[30], sigbit, amt[2]);
	mux2to1 mux231(from2[31], from1[31], sigbit, amt[2]);
	
	//col3
	mux2to1 mux30(from3[0], from2[0], from2[8], amt[3]);
	mux2to1 mux31(from3[1], from2[1], from2[9], amt[3]);
	mux2to1 mux32(from3[2], from2[2], from2[10], amt[3]);
	mux2to1 mux33(from3[3], from2[3], from2[11], amt[3]);
	mux2to1 mux34(from3[4], from2[4], from2[12], amt[3]);
	mux2to1 mux35(from3[5], from2[5], from2[13], amt[3]);
	mux2to1 mux36(from3[6], from2[6], from2[14], amt[3]);
	mux2to1 mux37(from3[7], from2[7], from2[15], amt[3]);
	mux2to1 mux38(from3[8], from2[8], from2[16], amt[3]);
	mux2to1 mux39(from3[9], from2[9], from2[17], amt[3]);
	mux2to1 mux310(from3[10], from2[10], from2[18], amt[3]);
	mux2to1 mux311(from3[11], from2[11], from2[19], amt[3]);
	mux2to1 mux312(from3[12], from2[12], from2[20], amt[3]);
	mux2to1 mux313(from3[13], from2[13], from2[21], amt[3]);
	mux2to1 mux314(from3[14], from2[14], from2[22], amt[3]);
	mux2to1 mux315(from3[15], from2[15], from2[23], amt[3]);
	mux2to1 mux316(from3[16], from2[16], from2[24], amt[3]);
	mux2to1 mux317(from3[17], from2[17], from2[25], amt[3]);
	mux2to1 mux318(from3[18], from2[18], from2[26], amt[3]);
	mux2to1 mux319(from3[19], from2[19], from2[27], amt[3]);
	mux2to1 mux320(from3[20], from2[20], from2[28], amt[3]);
	mux2to1 mux321(from3[21], from2[21], from2[29], amt[3]);
	mux2to1 mux322(from3[22], from2[22], from2[30], amt[3]);
	mux2to1 mux323(from3[23], from2[23], from2[31], amt[3]);
	mux2to1 mux324(from3[24], from2[24], sigbit, amt[3]);
	mux2to1 mux325(from3[25], from2[25], sigbit, amt[3]);
	mux2to1 mux326(from3[26], from2[26], sigbit, amt[3]);
	mux2to1 mux327(from3[27], from2[27], sigbit, amt[3]);
	mux2to1 mux328(from3[28], from2[28], sigbit, amt[3]);
	mux2to1 mux329(from3[29], from2[29], sigbit, amt[3]);
	mux2to1 mux330(from3[30], from2[30], sigbit, amt[3]);
	mux2to1 mux331(from3[31], from2[31], sigbit, amt[3]);
	
	//col4
	mux2to1 mux40(out[0], from3[0], from3[16], amt[4]);
	mux2to1 mux41(out[1], from3[1], from3[17], amt[4]);
	mux2to1 mux42(out[2], from3[2], from3[18], amt[4]);
	mux2to1 mux43(out[3], from3[3], from3[19], amt[4]);
	mux2to1 mux44(out[4], from3[4], from3[20], amt[4]);
	mux2to1 mux45(out[5], from3[5], from3[21], amt[4]);
	mux2to1 mux46(out[6], from3[6], from3[22], amt[4]);
	mux2to1 mux47(out[7], from3[7], from3[23], amt[4]);
	mux2to1 mux48(out[8], from3[8], from3[24], amt[4]);
	mux2to1 mux49(out[9], from3[9], from3[25], amt[4]);
	mux2to1 mux410(out[10], from3[10], from3[26], amt[4]);
	mux2to1 mux411(out[11], from3[11], from3[27], amt[4]);
	mux2to1 mux412(out[12], from3[12], from3[28], amt[4]);
	mux2to1 mux413(out[13], from3[13], from3[29], amt[4]);
	mux2to1 mux414(out[14], from3[14], from3[30], amt[4]);
	mux2to1 mux415(out[15], from3[15], from3[31], amt[4]);
	mux2to1 mux416(out[16], from3[16], sigbit, amt[4]);
	mux2to1 mux417(out[17], from3[17], sigbit, amt[4]);
	mux2to1 mux418(out[18], from3[18], sigbit, amt[4]);
	mux2to1 mux419(out[19], from3[19], sigbit, amt[4]);
	mux2to1 mux420(out[20], from3[20], sigbit, amt[4]);
	mux2to1 mux421(out[21], from3[21], sigbit, amt[4]);
	mux2to1 mux422(out[22], from3[22], sigbit, amt[4]);
	mux2to1 mux423(out[23], from3[23], sigbit, amt[4]);
	mux2to1 mux424(out[24], from3[24], sigbit, amt[4]);
	mux2to1 mux425(out[25], from3[25], sigbit, amt[4]);
	mux2to1 mux426(out[26], from3[26], sigbit, amt[4]);
	mux2to1 mux427(out[27], from3[27], sigbit, amt[4]);
	mux2to1 mux428(out[28], from3[28], sigbit, amt[4]);
	mux2to1 mux429(out[29], from3[29], sigbit, amt[4]);
	mux2to1 mux430(out[30], from3[30], sigbit, amt[4]);
	mux2to1 mux431(out[31], from3[31], sigbit, amt[4]);
endmodule

module sll(out, in, amt);
	input[31:0] in;
	input[4:0] amt;
	output[31:0] out;
	
	wire zero;
	assign zero = 0;
	
	//muxcolrow
	wire from0[31:0], from1[31:0], from2[31:0], from3[31:0];
	
	//col0
	mux2to1 mux00(from0[0], in[0], zero, amt[0]);
	mux2to1 mux01(from0[1], in[1], in[0], amt[0]);
	mux2to1 mux02(from0[2], in[2], in[1], amt[0]);
	mux2to1 mux03(from0[3], in[3], in[2], amt[0]);
	mux2to1 mux04(from0[4], in[4], in[3], amt[0]);
	mux2to1 mux05(from0[5], in[5], in[4], amt[0]);
	mux2to1 mux06(from0[6], in[6], in[5], amt[0]);
	mux2to1 mux07(from0[7], in[7], in[6], amt[0]);
	mux2to1 mux08(from0[8], in[8], in[7], amt[0]);
	mux2to1 mux09(from0[9], in[9], in[8], amt[0]);
	mux2to1 mux010(from0[10], in[10], in[9], amt[0]);
	mux2to1 mux011(from0[11], in[11], in[10], amt[0]);
	mux2to1 mux012(from0[12], in[12], in[11], amt[0]);
	mux2to1 mux013(from0[13], in[13], in[12], amt[0]);
	mux2to1 mux014(from0[14], in[14], in[13], amt[0]);
	mux2to1 mux015(from0[15], in[15], in[14], amt[0]);
	mux2to1 mux016(from0[16], in[16], in[15], amt[0]);
	mux2to1 mux017(from0[17], in[17], in[16], amt[0]);
	mux2to1 mux018(from0[18], in[18], in[17], amt[0]);
	mux2to1 mux019(from0[19], in[19], in[18], amt[0]);
	mux2to1 mux020(from0[20], in[20], in[19], amt[0]);
	mux2to1 mux021(from0[21], in[21], in[20], amt[0]);
	mux2to1 mux022(from0[22], in[22], in[21], amt[0]);
	mux2to1 mux023(from0[23], in[23], in[22], amt[0]);
	mux2to1 mux024(from0[24], in[24], in[23], amt[0]);
	mux2to1 mux025(from0[25], in[25], in[24], amt[0]);
	mux2to1 mux026(from0[26], in[26], in[25], amt[0]);
	mux2to1 mux027(from0[27], in[27], in[26], amt[0]);
	mux2to1 mux028(from0[28], in[28], in[27], amt[0]);
	mux2to1 mux029(from0[29], in[29], in[28], amt[0]);
	mux2to1 mux030(from0[30], in[30], in[29], amt[0]);
	mux2to1 mux031(from0[31], in[31], in[30], amt[0]);
	
	//col1
	mux2to1 mux10(from1[0], from0[0], zero, amt[1]);
	mux2to1 mux11(from1[1], from0[1], zero, amt[1]);
	mux2to1 mux12(from1[2], from0[2], from0[0], amt[1]);
	mux2to1 mux13(from1[3], from0[3], from0[1], amt[1]);
	mux2to1 mux14(from1[4], from0[4], from0[2], amt[1]);
	mux2to1 mux15(from1[5], from0[5], from0[3], amt[1]);
	mux2to1 mux16(from1[6], from0[6], from0[4], amt[1]);
	mux2to1 mux17(from1[7], from0[7], from0[5], amt[1]);
	mux2to1 mux18(from1[8], from0[8], from0[6], amt[1]);
	mux2to1 mux19(from1[9], from0[9], from0[7], amt[1]);
	mux2to1 mux110(from1[10], from0[10], from0[8], amt[1]);
	mux2to1 mux111(from1[11], from0[11], from0[9], amt[1]);
	mux2to1 mux112(from1[12], from0[12], from0[10], amt[1]);
	mux2to1 mux113(from1[13], from0[13], from0[11], amt[1]);
	mux2to1 mux114(from1[14], from0[14], from0[12], amt[1]);
	mux2to1 mux115(from1[15], from0[15], from0[13], amt[1]);
	mux2to1 mux116(from1[16], from0[16], from0[14], amt[1]);
	mux2to1 mux117(from1[17], from0[17], from0[15], amt[1]);
	mux2to1 mux118(from1[18], from0[18], from0[16], amt[1]);
	mux2to1 mux119(from1[19], from0[19], from0[17], amt[1]);
	mux2to1 mux120(from1[20], from0[20], from0[18], amt[1]);
	mux2to1 mux121(from1[21], from0[21], from0[19], amt[1]);
	mux2to1 mux122(from1[22], from0[22], from0[20], amt[1]);
	mux2to1 mux123(from1[23], from0[23], from0[21], amt[1]);
	mux2to1 mux124(from1[24], from0[24], from0[22], amt[1]);
	mux2to1 mux125(from1[25], from0[25], from0[23], amt[1]);
	mux2to1 mux126(from1[26], from0[26], from0[24], amt[1]);
	mux2to1 mux127(from1[27], from0[27], from0[25], amt[1]);
	mux2to1 mux128(from1[28], from0[28], from0[26], amt[1]);
	mux2to1 mux129(from1[29], from0[29], from0[27], amt[1]);
	mux2to1 mux130(from1[30], from0[30], from0[28], amt[1]);
	mux2to1 mux131(from1[31], from0[31], from0[29], amt[1]);
	
	//col2
	mux2to1 mux20(from2[0], from1[0], zero, amt[2]);
	mux2to1 mux21(from2[1], from1[1], zero, amt[2]);
	mux2to1 mux22(from2[2], from1[2], zero, amt[2]);
	mux2to1 mux23(from2[3], from1[3], zero, amt[2]);
	mux2to1 mux24(from2[4], from1[4], from1[0], amt[2]);
	mux2to1 mux25(from2[5], from1[5], from1[1], amt[2]);
	mux2to1 mux26(from2[6], from1[6], from1[2], amt[2]);
	mux2to1 mux27(from2[7], from1[7], from1[3], amt[2]);
	mux2to1 mux28(from2[8], from1[8], from1[4], amt[2]);
	mux2to1 mux29(from2[9], from1[9], from1[5], amt[2]);
	mux2to1 mux210(from2[10], from1[10], from1[6], amt[2]);
	mux2to1 mux211(from2[11], from1[11], from1[7], amt[2]);
	mux2to1 mux212(from2[12], from1[12], from1[8], amt[2]);
	mux2to1 mux213(from2[13], from1[13], from1[9], amt[2]);
	mux2to1 mux214(from2[14], from1[14], from1[10], amt[2]);
	mux2to1 mux215(from2[15], from1[15], from1[11], amt[2]);
	mux2to1 mux216(from2[16], from1[16], from1[12], amt[2]);
	mux2to1 mux217(from2[17], from1[17], from1[13], amt[2]);
	mux2to1 mux218(from2[18], from1[18], from1[14], amt[2]);
	mux2to1 mux219(from2[19], from1[19], from1[15], amt[2]);
	mux2to1 mux220(from2[20], from1[20], from1[16], amt[2]);
	mux2to1 mux221(from2[21], from1[21], from1[17], amt[2]);
	mux2to1 mux222(from2[22], from1[22], from1[18], amt[2]);
	mux2to1 mux223(from2[23], from1[23], from1[19], amt[2]);
	mux2to1 mux224(from2[24], from1[24], from1[20], amt[2]);
	mux2to1 mux225(from2[25], from1[25], from1[21], amt[2]);
	mux2to1 mux226(from2[26], from1[26], from1[22], amt[2]);
	mux2to1 mux227(from2[27], from1[27], from1[23], amt[2]);
	mux2to1 mux228(from2[28], from1[28], from1[24], amt[2]);
	mux2to1 mux229(from2[29], from1[29], from1[25], amt[2]);
	mux2to1 mux230(from2[30], from1[30], from1[26], amt[2]);
	mux2to1 mux231(from2[31], from1[31], from1[27], amt[2]);
	
	//col3
	mux2to1 mux30(from3[0], from2[0], zero, amt[3]);
	mux2to1 mux31(from3[1], from2[1], zero, amt[3]);
	mux2to1 mux32(from3[2], from2[2], zero, amt[3]);
	mux2to1 mux33(from3[3], from2[3], zero, amt[3]);
	mux2to1 mux34(from3[4], from2[4], zero, amt[3]);
	mux2to1 mux35(from3[5], from2[5], zero, amt[3]);
	mux2to1 mux36(from3[6], from2[6], zero, amt[3]);
	mux2to1 mux37(from3[7], from2[7], zero, amt[3]);
	mux2to1 mux38(from3[8], from2[8], from2[0], amt[3]);
	mux2to1 mux39(from3[9], from2[9], from2[1], amt[3]);
	mux2to1 mux310(from3[10], from2[10], from2[2], amt[3]);
	mux2to1 mux311(from3[11], from2[11], from2[3], amt[3]);
	mux2to1 mux312(from3[12], from2[12], from2[4], amt[3]);
	mux2to1 mux313(from3[13], from2[13], from2[5], amt[3]);
	mux2to1 mux314(from3[14], from2[14], from2[6], amt[3]);
	mux2to1 mux315(from3[15], from2[15], from2[7], amt[3]);
	mux2to1 mux316(from3[16], from2[16], from2[8], amt[3]);
	mux2to1 mux317(from3[17], from2[17], from2[9], amt[3]);
	mux2to1 mux318(from3[18], from2[18], from2[10], amt[3]);
	mux2to1 mux319(from3[19], from2[19], from2[11], amt[3]);
	mux2to1 mux320(from3[20], from2[20], from2[12], amt[3]);
	mux2to1 mux321(from3[21], from2[21], from2[13], amt[3]);
	mux2to1 mux322(from3[22], from2[22], from2[14], amt[3]);
	mux2to1 mux323(from3[23], from2[23], from2[15], amt[3]);
	mux2to1 mux324(from3[24], from2[24], from2[16], amt[3]);
	mux2to1 mux325(from3[25], from2[25], from2[17], amt[3]);
	mux2to1 mux326(from3[26], from2[26], from2[18], amt[3]);
	mux2to1 mux327(from3[27], from2[27], from2[19], amt[3]);
	mux2to1 mux328(from3[28], from2[28], from2[20], amt[3]);
	mux2to1 mux329(from3[29], from2[29], from2[21], amt[3]);
	mux2to1 mux330(from3[30], from2[30], from2[22], amt[3]);
	mux2to1 mux331(from3[31], from2[31], from2[23], amt[3]);
	
	//col4
	mux2to1 mux40(out[0], from3[0], zero, amt[4]);
	mux2to1 mux41(out[1], from3[1], zero, amt[4]);
	mux2to1 mux42(out[2], from3[2], zero, amt[4]);
	mux2to1 mux43(out[3], from3[3], zero, amt[4]);
	mux2to1 mux44(out[4], from3[4], zero, amt[4]);
	mux2to1 mux45(out[5], from3[5], zero, amt[4]);
	mux2to1 mux46(out[6], from3[6], zero, amt[4]);
	mux2to1 mux47(out[7], from3[7], zero, amt[4]);
	mux2to1 mux48(out[8], from3[8], zero, amt[4]);
	mux2to1 mux49(out[9], from3[9], zero, amt[4]);
	mux2to1 mux410(out[10], from3[10], zero, amt[4]);
	mux2to1 mux411(out[11], from3[11], zero, amt[4]);
	mux2to1 mux412(out[12], from3[12], zero, amt[4]);
	mux2to1 mux413(out[13], from3[13], zero, amt[4]);
	mux2to1 mux414(out[14], from3[14], zero, amt[4]);
	mux2to1 mux415(out[15], from3[15], zero, amt[4]);
	mux2to1 mux416(out[16], from3[16], from3[0], amt[4]);
	mux2to1 mux417(out[17], from3[17], from3[1], amt[4]);
	mux2to1 mux418(out[18], from3[18], from3[2], amt[4]);
	mux2to1 mux419(out[19], from3[19], from3[3], amt[4]);
	mux2to1 mux420(out[20], from3[20], from3[4], amt[4]);
	mux2to1 mux421(out[21], from3[21], from3[5], amt[4]);
	mux2to1 mux422(out[22], from3[22], from3[6], amt[4]);
	mux2to1 mux423(out[23], from3[23], from3[7], amt[4]);
	mux2to1 mux424(out[24], from3[24], from3[8], amt[4]);
	mux2to1 mux425(out[25], from3[25], from3[9], amt[4]);
	mux2to1 mux426(out[26], from3[26], from3[10], amt[4]);
	mux2to1 mux427(out[27], from3[27], from3[11], amt[4]);
	mux2to1 mux428(out[28], from3[28], from3[12], amt[4]);
	mux2to1 mux429(out[29], from3[29], from3[13], amt[4]);
	mux2to1 mux430(out[30], from3[30], from3[14], amt[4]);
	mux2to1 mux431(out[31], from3[31], from3[15], amt[4]);
	
endmodule

module mux2to1(out, in1, in2, sel);
	input in1, in2, sel;
	output out;
	
	assign out = sel? in2: in1;
endmodule

module bitOr(out, in1, in2);
	input[31:0] in1, in2;
	output[31:0] out;
	
	or or0(out[0], in1[0], in2[0]);
	or or1(out[1], in1[1], in2[1]);
	or or2(out[2], in1[2], in2[2]);
	or or3(out[3], in1[3], in2[3]);
	or or4(out[4], in1[4], in2[4]);
	or or5(out[5], in1[5], in2[5]);
	or or6(out[6], in1[6], in2[6]);
	or or7(out[7], in1[7], in2[7]);
	or or8(out[8], in1[8], in2[8]);
	or or9(out[9], in1[9], in2[9]);
	or or10(out[10], in1[10], in2[10]);
	or or11(out[11], in1[11], in2[11]);
	or or12(out[12], in1[12], in2[12]);
	or or13(out[13], in1[13], in2[13]);
	or or14(out[14], in1[14], in2[14]);
	or or15(out[15], in1[15], in2[15]);
	or or16(out[16], in1[16], in2[16]);
	or or17(out[17], in1[17], in2[17]);
	or or18(out[18], in1[18], in2[18]);
	or or19(out[19], in1[19], in2[19]);
	or or20(out[20], in1[20], in2[20]);
	or or21(out[21], in1[21], in2[21]);
	or or22(out[22], in1[22], in2[22]);
	or or23(out[23], in1[23], in2[23]);
	or or24(out[24], in1[24], in2[24]);
	or or25(out[25], in1[25], in2[25]);
	or or26(out[26], in1[26], in2[26]);
	or or27(out[27], in1[27], in2[27]);
	or or28(out[28], in1[28], in2[28]);
	or or29(out[29], in1[29], in2[29]);
	or or30(out[30], in1[30], in2[30]);
	or or31(out[31], in1[31], in2[31]);
endmodule

module bitAnd(out, in1, in2);
	input[31:0] in1, in2;
	output[31:0] out;
	
	and and0(out[0], in1[0], in2[0]);
	and and1(out[1], in1[1], in2[1]);
	and and2(out[2], in1[2], in2[2]);
	and and3(out[3], in1[3], in2[3]);
	and and4(out[4], in1[4], in2[4]);
	and and5(out[5], in1[5], in2[5]);
	and and6(out[6], in1[6], in2[6]);
	and and7(out[7], in1[7], in2[7]);
	and and8(out[8], in1[8], in2[8]);
	and and9(out[9], in1[9], in2[9]);
	and and10(out[10], in1[10], in2[10]);
	and and11(out[11], in1[11], in2[11]);
	and and12(out[12], in1[12], in2[12]);
	and and13(out[13], in1[13], in2[13]);
	and and14(out[14], in1[14], in2[14]);
	and and15(out[15], in1[15], in2[15]);
	and and16(out[16], in1[16], in2[16]);
	and and17(out[17], in1[17], in2[17]);
	and and18(out[18], in1[18], in2[18]);
	and and19(out[19], in1[19], in2[19]);
	and and20(out[20], in1[20], in2[20]);
	and and21(out[21], in1[21], in2[21]);
	and and22(out[22], in1[22], in2[22]);
	and and23(out[23], in1[23], in2[23]);
	and and24(out[24], in1[24], in2[24]);
	and and25(out[25], in1[25], in2[25]);
	and and26(out[26], in1[26], in2[26]);
	and and27(out[27], in1[27], in2[27]);
	and and28(out[28], in1[28], in2[28]);
	and and29(out[29], in1[29], in2[29]);
	and and30(out[30], in1[30], in2[30]);
	and and31(out[31], in1[31], in2[31]);
endmodule

module partialcarryLookAdder(in1, in2, cin, sum, cout);
    input [31:0] in1, in2;
    input cin;
    output [31:0] sum;
    output cout;
	 
	 wire c1, c2, c3, c4, c5, c6, c7;
	 
	 cla4 cla03(in1[3:0], in2[3:0], cin, sum[3:0], c1);
	 cla4 cla47(in1[7:4], in2[7:4], c1, sum[7:4], c2);
	 cla4 cla811(in1[11:8], in2[11:8], c2, sum[11:8], c3);
	 cla4 cla1215(in1[15:12], in2[15:12], c3, sum[15:12], c4);
	 cla4 cla1619(in1[19:16], in2[19:16], c4, sum[19:16], c5);
	 cla4 cla2023(in1[23:20], in2[23:20], c5, sum[23:20], c6);
	 cla4 cla2427(in1[27:24], in2[27:24], c6, sum[27:24], c7);
	 cla4 cla2831(in1[31:28], in2[31:28], c7, sum[31:28], cout);
	 
endmodule

module cla4(in1, in2, cin, sum, cout);

	input[3:0] in1, in2;
	input cin;
	output cout;
	output[3:0] sum;

	wire gminus1, g0, p0, g1, p1, g2, p2, g3, p3, c1, c2, c3;
	assign gminus1 = cin;

	carryLookCell myclc0(in1[0], in2[0], cin, g0, p0, sum[0]);
	
	wire temp1;
	and and1(temp1, gminus1, p0);
	or or1(c1, temp1, g0);
	
	carryLookCell myclc1(in1[1], in2[1], c1, g1, p1, sum[1]);
	
	wire temp2, temp3;
	and and2(temp2, gminus1, p0, p1);
	and and3(temp3, g0, p1);
	or or2(c2, temp2, temp3, g1);
	
	carryLookCell myclc2(in1[2], in2[2], c2, g2, p2, sum[2]);
	
	wire temp4, temp5, temp6;
	and and4(temp4, gminus1, p0, p1, p2);
	and and5(temp5, g0, p1, p2);
	and and6(temp6, g1, p2);
	or or3(c3, temp4, temp5, temp6, g2);
	
	carryLookCell myclc3(in1[3], in2[3], c3, g3, p3, sum[3]);
	
	wire temp7, temp8, temp9, temp10;
	and and7(temp7, gminus1, p0, p1, p2, p3);
	and and8(temp8, g0, p1, p2, p3);
	and and9(temp9, g1, p2, p3);
	and and10(temp10, g2, p3);
	or or4(cout, temp7, temp8, temp9, temp10, g3);

endmodule

module carryLookCell(in1, in2, cin, gout, pout, sout);
    input in1, in2, cin;
    output gout, pout, sout;
    
    wire temp;
    
    and myand(gout, in1, in2);
    or myor(pout, in1, in2);
	 xor myxor(sout, cin, in1, in2);
endmodule