`include "defines.v"

module pc(
	input wire rst, 
	
	input wire inst, 
	
	input wire jump, 
	input wire [`INST_ADDR_WIDTH] jump_addr, 
	input wire [1:0] hold, 
	
	output wire [`INST_ADDR_WIDTH] pc_o, 
	output wire [`INST_WIDTH] inst_o
	);
	
	assign inst_o = inst;
	
	assign pc_o = 
		(rst == `RST) ? `INI_INST_ADDR : 
		(jump == `JUMP) ? jump_addr : 
		(hold == `HOLD) ? pc_o : 
		pc_o + 32'h4; 
	
endmodule