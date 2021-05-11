`include "defines.v"

module fliop1(
	input wire clk, 
	input wire rst, 
	input wire flush, 
	
	input wire [`INST_WIDTH] inst, 
	input wire [`INST_ADDR_WIDTH] inst_addr, 
	
	output wire [`INST_WIDTH] inst_o, 
	output wire [`INST_ADDR_WIDTH] inst_addr_o
	);
	
	wire [`INST_WIDTH] inst_r; 
	gnrl_dff #(32) inst_dff(clk, rst, flush, `NOP, inst, inst_r); 
	assign inst_o = inst_r;
	
	wire [`INST_ADDR_WIDTH] inst_addr_r; 
	gnrl_dff #(32) inst_addr_dff(clk, rst, flush, `INI_INST_ADDR, inst_addr, inst_addr_r); 
	assign inst_addr_o = inst_addr_r; 
	
endmodule