module Control_module(clk,rst_n,seq_rdy,data_ack,currentState,inputBit);
	input clk,rst_n;
	input seq_rdy;
	output reg data_ack;
	output reg [1:0] currentState;
    output reg inputBit;
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			currentState <= 2'b11;
		end else if(seq_rdy && inputBit)begin
			if(currentState == 3)begin
				currentState <= 2'b00;
			end else begin
				currentState <= currentState + 1;
			end
				
		end
	end
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			inputBit <= 1 ; 
		end else begin
			inputBit <= ~inputBit;  
		end
	end
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			data_ack <= 0 ; 
		end else if(currentState == 3)begin
			data_ack <= 1;  
		end else begin
			data_ack <= 0;
		end
	end

endmodule
