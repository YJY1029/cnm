`include "defines.v"

module pc(
	input wire clk, 
	input wire rst, 
	
	input wire [`INST_WIDTH] inst, //0
	
	input wire jump, 
	input wire [`INST_ADDR_WIDTH] jump_addr, 
	input wire hold, 
	
	output reg [`INST_ADDR_WIDTH] pc_o, 
	output wire [`INST_WIDTH] inst_o
	);
	
	assign inst_o = inst; 
	
	always @ (posedge clk) begin
		if (rst == `RST) begin
			pc_o = `INI_INST_ADDR; 
		end else if (jump == `JUMP) begin
			pc_o = jump_addr; 
		end else if (hold == `HOLD) begin 
			pc_o = pc_o; 
		end else begin
			pc_o = pc_o+32'h4; 
		end
	end
endmodule