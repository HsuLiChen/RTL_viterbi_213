module Top_module(clk,rst_n,rx,seq_rdy,data_ack);
	input clk,rst_n;
	input [1:0]rx;
	input seq_rdy;
	output wire data_ack;
	wire [1:0] currentState;
    wire inputBit;
	wire [2:0] hamming_dist;
	
	Control_module c1(
		.clk(clk),
		.rst_n(rst_n),
		.seq_rdy(seq_rdy),
		.data_ack(data_ack),
		.currentState(currentState),
		.inputBit(inputBit)
	);
	
	BMC_model b1(
		.rec_code(rx),
		.hamming_dist(hamming_dist),
		.currentState(currentState),
		.inputBit(inputBit)
	);
	
	PMU_model p1(
		.clk(clk),
		.rst_n(rst_n),
		.hamming_dist(hamming_dist),
		.currentState(currentState),
		.inputBit(inputBit)
	);
	
endmodule