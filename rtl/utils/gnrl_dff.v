module gnrl_dff #(
	parameter DW = 32
)(
	input clk, 
	input rst, 
	input flush, 
	
	input [DW-1:0] dis_val, 
	input [DW-1:0] din, 
	output [DW-1:0] qout
);
	
	reg [DW-1:0] qout_r; 
	
	always @ (posedge clk) begin
		if (!rst | flush) begin 
			qout_r <= dis_val; 
		end else begin 
			qout_r <= din; 
		end 
	end 
	
	assign qout = qout_r; 
	
endmodule 