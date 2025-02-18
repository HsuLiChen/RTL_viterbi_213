module PMU_model (
    input clk,
    input rst_n,
    input [2:0] hamming_dist,
    input [1:0] currentState,
    input inputBit
); 

    reg [3:0] path_metrics [0:3];
    reg [3:0] new_metrics [0:3];
    reg [3:0] candidate_metric;
    reg [1:0] nextState;
    reg [3:0] count;
	reg [12:0] survivors [0:3];
	reg [12:0] new_survivors [0:3];
	
	assign candidate_metric = path_metrics[currentState] + hamming_dist;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            path_metrics[0] <= 4'd0;
            path_metrics[1] <= 4'd3;
            path_metrics[2] <= 4'd3;
            path_metrics[3] <= 4'd3;
        end else if (count == 8) begin
            path_metrics[0] <= new_metrics[0];
            path_metrics[1] <= new_metrics[1];
            path_metrics[2] <= new_metrics[2];
            path_metrics[3] <= new_metrics[3];
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            new_metrics[0] <= 4'd3;
            new_metrics[1] <= 4'd3;
            new_metrics[2] <= 4'd3;
            new_metrics[3] <= 4'd3;
        end else if (count == 8) begin
            new_metrics[0] <= 4'd3;
            new_metrics[1] <= 4'd3;
            new_metrics[2] <= 4'd3;
            new_metrics[3] <= 4'd3;
        end else begin
            
            if (candidate_metric < new_metrics[nextState]) begin
                case (nextState)
                    2'd0: new_metrics[0] <= candidate_metric;
                    2'd1: new_metrics[1] <= candidate_metric;
                    2'd2: new_metrics[2] <= candidate_metric;
                    2'd3: new_metrics[3] <= candidate_metric;
                endcase
            end
        end
    end
	
	always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            survivors[0] <= 0;
            survivors[1] <= 0;
            survivors[2] <= 0;
            survivors[3] <= 0;
			survivors[4] <= 0;
			survivors[5] <= 0;
			survivors[6] <= 0;
			survivors[7] <= 0;
			survivors[8] <= 0;
			survivors[9] <= 0;
			survivors[10] <= 0;
			survivors[11] <= 0;
			survivors[12] <= 0;
        end else begin
			if(count == 8)begin
				survivors[0] <= new_survivors[0];
				survivors[1] <= new_survivors[1];
				survivors[2] <= new_survivors[2];
				survivors[3] <= new_survivors[3];
				survivors[4] <= new_survivors[4];
				survivors[5] <= new_survivors[5];
				survivors[6] <= new_survivors[6];
				survivors[7] <= new_survivors[7];
				survivors[8] <= new_survivors[8];
				survivors[9] <= new_survivors[9];
				survivors[10] <= new_survivors[10];
				survivors[11] <= new_survivors[11];
				survivors[12] <= new_survivors[12];
			end
		end
    end
	
	always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            new_survivors[0] <= 0;
            new_survivors[1] <= 0;
            new_survivors[2] <= 0;
            new_survivors[3] <= 0;
			new_survivors[4] <= 0;
			new_survivors[5] <= 0;
			new_survivors[6] <= 0;
			new_survivors[7] <= 0;
			new_survivors[8] <= 0;
			new_survivors[9] <= 0;
			new_survivors[10] <= 0;
			new_survivors[11] <= 0;
			new_survivors[12] <= 0;
        end else begin
            if (candidate_metric < new_metrics[nextState]) begin
				case (nextState)
					2'd0:new_survivors[0] <= {survivors[currentState][11:0], inputBit}; 
					2'd1:new_survivors[1] <= {survivors[currentState][11:0], inputBit}; 
					2'd2:new_survivors[2] <= {survivors[currentState][11:0], inputBit}; 
					2'd3:new_survivors[3] <= {survivors[currentState][11:0], inputBit}; 
				endcase
                
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
        end else begin
            if (count == 8) begin
                count <= 1;
            end else begin
                count <= count + 1;
            end    
        end
    end

    always @(*) begin
        if (!rst_n) begin
            nextState = 0;
        end else begin
            case (currentState)
                2'd0: nextState = (inputBit == 0) ? 2'd0 : 2'd2;
                2'd1: nextState = (inputBit == 0) ? 2'd0 : 2'd2;
                2'd2: nextState = (inputBit == 0) ? 2'd1 : 2'd3;
                2'd3: nextState = (inputBit == 0) ? 2'd1 : 2'd3;
                default: nextState = 2'd0;
            endcase
        end
    end

endmodule
