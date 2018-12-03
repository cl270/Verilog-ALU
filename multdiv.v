module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY, outbits, sumtemp);
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    // Your code here
	 
	 
	  wire Bzeroes, divexception;
	 or or0(Bzeroes, data_operandB[0], data_operandB[1], data_operandB[2], data_operandB[3], data_operandB[4], data_operandB[5], data_operandB[6], data_operandB[7], data_operandB[8], data_operandB[9], data_operandB[10], data_operandB[11], data_operandB[12], data_operandB[13], data_operandB[14], data_operandB[15], data_operandB[16], data_operandB[17], data_operandB[18], data_operandB[19], data_operandB[20], data_operandB[21], data_operandB[22], data_operandB[23], data_operandB[24], data_operandB[25], data_operandB[26], data_operandB[27], data_operandB[28], data_operandB[29], data_operandB[30], data_operandB[31]);
	 and and0(divexception, ctrl_DIV, Bzeroes);
	 reg start, mult, div;
	 reg[63:0] thebits, thebitstemp;
	 
	 reg[31:0] alubits, secondbits;
	 reg bothzero;
	 
	 always @ (posedge clock) begin
		bothzero = ~ctrl_DIV && ~ctrl_MULT;
		
		alubits = bothzero ? alubits :(ctrl_DIV ? data_operandB : data_operandA);
		secondbits = bothzero? secondbits: (ctrl_DIV  ? data_operandA : data_operandB);
	 end

	 
	 wire isNotEqual, isLessThan, notneededof2, isNotEqual2, isLessThan2, isNotEqual3, isLessThan3, notneededof3, addoverflow;
	 wire[31:0] tempsum, tempdiff;
	 
	 alu myalu(thebits[63:32], alubits, 5'b0, 5'b0, tempsum, isNotEqual, isLessThan, addoverflow);
	 alu myalusub(thebits[63:32], alubits, 5'b1, 5'b0, tempdiff, isNotEqual, isLessThan, addoverflow);
	 wire isBneg;
	 assign isBneg = secondbits[31];
	 wire[31:0] newdataBtemp, negdataBtemp, newdataB;
	 assign newdataBtemp = isBneg ? ~secondbits : secondbits;
	 alu addone(newdataBtemp, 32'b00000000000000000000000000000001, 5'b0, 5'b0, negdataBtemp, isNotEqual2, isLessThan2, notneededof2);
	 assign newdataB = isBneg ? negdataBtemp : newdataBtemp; 
	 
	 always @ (negedge clock) begin
			start =  ctrl_MULT || ctrl_DIV;
			mult = start? ctrl_MULT : mult;
			div = start? ctrl_DIV : div;	
			
			thebits[63:32] = thebits[0] && ~data_resultRDY && mult ? tempsum : thebits[63:32];
			thebits[63:32] = div&&~tempdiff[31]? tempdiff :thebits[63:32];
			thebitstemp =  thebits <<< 1;
			thebits = data_resultRDY ? thebits:((ctrl_MULT||ctrl_DIV) ?  {32'b0, newdataB} : (div ? {thebitstemp[63:1],~tempdiff[31]} : thebits >>> 1)); // more logic
			
	 end

	 wire[5:0] out;
	 counter_32 mycounter(clock, ctrl_MULT||ctrl_DIV, out);
	 
	 wire overflow, multoverflow, tempexception;
	 wire onenegative, twonegative;
	 xor xor1(onenegative,data_operandA[31],data_operandB[31]);
	 and and1111(twonegative,data_operandA[31],data_operandB[31]);
	 
	 wire intermediatebits;
	 or or1000(intermediatebits, thebits[32], thebits[33], thebits[34], thebits[35], thebits[36], thebits[37], thebits[38], thebits[39], thebits[40], thebits[41], thebits[42], thebits[43], thebits[44], thebits[45], thebits[46], thebits[47], thebits[48], thebits[49], thebits[50], thebits[51], thebits[52], thebits[53], thebits[54], thebits[55], thebits[56], thebits[57], thebits[58], thebits[59], thebits[60], thebits[61], thebits[62]);
	 or or101(multoverflow, thebits[31]&& ~onenegative&&~twonegative, thebits[63], intermediatebits && ~twonegative);
	 or or111(tempexception, multoverflow&&~div, divexception);
	 
	 wire isend, ender;
	 and and111111(isend, out[0], ~out[1], ~out[2], ~out[3], ~out[4], out[5]);
	 and and11111(ender, ~out[0], out[1], ~out[2], ~out[3], ~out[4], out[5]);	 
	 
	 or or11111(data_resultRDY, isend&&mult, ender&&div);
	 and and110(data_exception, tempexception, data_resultRDY);
	 
	 wire[31:0] tempresult, tempresult2, tempresult3;
	 assign tempresult = isBneg ? ~thebits[31:0] : thebits[31:0];
	 alu addoneagain(tempresult, 32'b00000000000000000000000000000001, 5'b0, 5'b0, tempresult2, isNotEqual3, isLessThan3, notneededof3); 
	 assign tempresult3 = isBneg ? tempresult2: tempresult;
	 //assign data_result = tempresult3;
	 wire tempresult0;
	 
	 and and0000(tempresult0, ~data_operandA[0], ~data_operandA[1], ~data_operandA[2], ~data_operandA[3], ~data_operandA[4], ~data_operandA[5], ~data_operandA[6], ~data_operandA[7], ~data_operandA[8], ~data_operandA[9], ~data_operandA[10], ~data_operandA[11], ~data_operandA[12], ~data_operandA[13], ~data_operandA[14], ~data_operandA[15], ~data_operandA[16], ~data_operandA[17], ~data_operandA[18], ~data_operandA[19], ~data_operandA[20], ~data_operandA[21], ~data_operandA[22], ~data_operandA[23], ~data_operandA[24], ~data_operandA[25], ~data_operandA[26], ~data_operandA[27], ~data_operandA[28], ~data_operandA[29], ~data_operandA[30], ~data_operandA[31]);
	 
	 assign data_result = tempresult0&&div ? 32'b0 : tempresult3;
	 
	 
	 output[63:0] outbits;
	 assign outbits = thebits;
	 
	 output[31:0] sumtemp;
	 assign sumtemp = tempsum;
endmodule



module dffposedge ( data, clk, q, clrn );
 
	input data, clk, clrn ; 
	output q;
	reg q;
   always @ ( posedge clk)
		q = ~clrn ? 1'b0 : data ;	
endmodule



module counter_32(clock, reset, out);
     input clock, reset;
     output [5:0] out;
     reg [5:0] next;

     dffposedge dff0(.data(next[0]), .clk(clock), .q(out[0]), .clrn(~reset));
     dffposedge dff1(.data(next[1]), .clk(clock), .q(out[1]), .clrn(~reset));
     dffposedge dff2(.data(next[2]), .clk(clock), .q(out[2]), .clrn(~reset));
	  dffposedge dff3(.data(next[3]), .clk(clock), .q(out[3]), .clrn(~reset));
	  dffposedge dff4(.data(next[4]), .clk(clock), .q(out[4]), .clrn(~reset));
	  dffposedge dff5(.data(next[5]), .clk(clock), .q(out[5]), .clrn(~reset));

     always@(*) begin
          casex({reset, out})
               //6'bxxxxx: next = 0;
               6'd0: next = 1;
					//6'b100001: next = 1;
               6'd1: next = 2;
               6'd2: next = 3;
               6'd3: next = 4;
               6'd4: next = 5;
               6'd5: next = 6;
               6'd6: next = 7;
               6'd7: next = 8;
					6'd8: next = 9;
               6'd9: next = 10;
               6'd10: next = 11;
               6'd11: next = 12;
               6'd12: next = 13;
               6'd13: next = 14;
               6'd14: next = 15;
               6'd15: next = 16;
					6'd16: next = 17;
               6'd17: next = 18;
               6'd18: next = 19;
               6'd19: next = 20;
               6'd20: next = 21;
               6'd21: next = 22;
               6'd22: next = 23;
               6'd23: next = 24;
					6'd24: next = 25;
               6'd25: next = 26;
               6'd26: next = 27;
               6'd27: next = 28;
               6'd28: next = 29;
               6'd29: next = 30;
               6'd30: next = 31;
               6'd31: next = 6'b100000;
					6'b100000: next = 6'b100001;
					6'b100001: next = 6'b100010;
					6'b100010: next = 6'b100011;
					6'b100011: next = 0;
               default: next = 0;
          endcase
     end
endmodule