module counter_8(clock, reset, out);
     input clock, reset;
     output [4:0] out;
     reg [4:0] next;

     dff dff0(.d(next[0]), .clk(clock), .q(out[0]), .clrn(~reset));
     dff dff1(.d(next[1]), .clk(clock), .q(out[1]), .clrn(~reset));
     dff dff2(.d(next[2]), .clk(clock), .q(out[2]), .clrn(~reset));
	  dff dff3(.d(next[3]), .clk(clock), .q(out[3]), .clrn(~reset));
	  dff dff4(.d(next[4]), .clk(clock), .q(out[4]), .clrn(~reset));

     always@(*) begin
          casex({reset, out})
               6'b1xxxxx: next = 0;
               6'd0: next = 1;
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
               6'd31: next = 31;
               default: next = 0;
          endcase
     end
endmodule
