module BMC_model(currentState,inputBit,rec_code,hamming_dist);
    input [1:0] rec_code;
	input [1:0] currentState;
    input inputBit;
	output reg[2:0] hamming_dist;
	reg [1:0] Cn;
	reg [1:0] expec_code;
	
	assign Cn = rec_code ^ expec_code;
	assign hamming_dist = Cn[1] + Cn[0];
	
	always@(*)begin
		case (currentState)
			2'd0:
				if(inputBit == 0)begin
					expec_code = 0;
				end else begin
					expec_code = 3;
				end
			2'd1:
				if(inputBit == 0)begin
					expec_code = 3;
				end else begin
					expec_code = 0;
				end
			2'd2:
				if(inputBit == 0)begin
					expec_code = 1;
				end else begin
					expec_code = 2;
				end
			2'd3:
				if(inputBit == 0)begin
					expec_code = 2;
				end else begin
					expec_code = 1;
				end
            default: expec_code = 2'd0;
        endcase
	end
endmodule
