`timescale 1ns/1ns
module model_tb_v1;
	reg clk,rst_n,seq_rdy;
	reg [1:0]rx;
	wire data_ack;
	reg signed [4:0]step;
	reg [3:0]count;
	reg signed[4:0]idx; 
	reg [23:0]conv_code;
	Top_module t1(
		.clk(clk),
		.rst_n(rst_n),
		.rx(rx),
		.seq_rdy(seq_rdy),
		.data_ack(data_ack)
	);
	
	initial begin
		clk = 0;
		forever begin
			clk = ~clk;
			#10 ;
		end
	end
	
    initial begin
        rst_n = 0;
        seq_rdy = 0;
        #20;
        rst_n = 1;
        seq_rdy = 1;
        conv_code = 24'b110100010001110000111101;
		rx =2'b11;
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            step <= 0;  
            idx <= -2;
            rx <= conv_code[0+:2]; 
        end else if (step == 12) begin
            $stop;
        end else if (data_ack) begin
            rx <= conv_code[idx+:2]; 
        end
    end
	
	always @(posedge data_ack) begin
        step <= step + 1;
		idx <= idx +2;		
    end
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			step <= -1;
			count <=-1;
		end else if(count == 6)begin
			$stop;
		end else if(data_ack)begin
			case(count)
				4'd0:rx <= 2'b11;
				4'd1:rx <= 2'b01;
				4'd2:rx <= 2'b00;
				4'd3:rx <= 2'b01;
				4'd4:rx <= 2'b00;
				4'd5:rx <= 2'b01;	
			endcase
		end
	end
	
	always @(posedge data_ack) begin
		count <= count +1;
    end
	

endmodule



